package main

import (
	"bytes"
	"crypto/sha256"
	"fmt"
	"image"
	_ "image/gif"
	"image/jpeg"
	_ "image/png"
	"io"
	"net/http"
	"os"
	"path/filepath"
	"sync"

	"golang.org/x/image/draw"
)

const (
	dataDir   = "data"
	thumbSize = 150
)

type ImageStore struct {
	mu     sync.RWMutex
	hashes map[string]string // hash -> file extension
}

func NewImageStore() *ImageStore {
	os.MkdirAll(filepath.Join(dataDir, "originals"), 0755)
	os.MkdirAll(filepath.Join(dataDir, "thumbnails"), 0755)
	return &ImageStore{hashes: make(map[string]string)}
}

func (is *ImageStore) HasImage(hash string) bool {
	is.mu.RLock()
	defer is.mu.RUnlock()
	_, ok := is.hashes[hash]
	return ok
}

func (is *ImageStore) OriginalURL(hash string) string {
	is.mu.RLock()
	defer is.mu.RUnlock()
	ext := is.hashes[hash]
	return fmt.Sprintf("/images/originals/%s.%s", hash, ext)
}

func (is *ImageStore) ThumbnailURL(hash string) string {
	return fmt.Sprintf("/images/thumbnails/%s.jpg", hash)
}

func (is *ImageStore) ProcessIcon(iconURL string) (string, error) {
	resp, err := http.Get(iconURL)
	if err != nil {
		return "", fmt.Errorf("download failed: %w", err)
	}
	defer resp.Body.Close()

	data, err := io.ReadAll(resp.Body)
	if err != nil {
		return "", fmt.Errorf("read failed: %w", err)
	}

	h := sha256.Sum256(data)
	hash := fmt.Sprintf("%x", h)

	if is.HasImage(hash) {
		return hash, nil
	}

	img, format, err := image.Decode(bytes.NewReader(data))
	if err != nil {
		return "", fmt.Errorf("unsupported image: %w", err)
	}

	ext := format
	if ext == "" {
		ext = "jpg"
	}

	origPath := filepath.Join(dataDir, "originals", hash+"."+ext)
	if err := os.WriteFile(origPath, data, 0644); err != nil {
		return "", err
	}

	thumb := makeThumbnail(img, thumbSize)
	thumbPath := filepath.Join(dataDir, "thumbnails", hash+".jpg")
	f, err := os.Create(thumbPath)
	if err != nil {
		return "", err
	}
	defer f.Close()
	if err := jpeg.Encode(f, thumb, &jpeg.Options{Quality: 80}); err != nil {
		return "", err
	}

	is.mu.Lock()
	is.hashes[hash] = ext
	is.mu.Unlock()

	return hash, nil
}

func makeThumbnail(img image.Image, maxSize int) image.Image {
	bounds := img.Bounds()
	w, h := bounds.Dx(), bounds.Dy()

	var newW, newH int
	if w > h {
		newW = maxSize
		newH = h * maxSize / w
	} else {
		newH = maxSize
		newW = w * maxSize / h
	}
	if newW < 1 {
		newW = 1
	}
	if newH < 1 {
		newH = 1
	}

	dst := image.NewRGBA(image.Rect(0, 0, newW, newH))
	draw.CatmullRom.Scale(dst, dst.Bounds(), img, bounds, draw.Over, nil)
	return dst
}
