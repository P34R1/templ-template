# Makefile for a Go project using templ and air

# Build the application
all: templ build

build: templ
	@echo Building...
	@go build -o main.exe ./cmd/...

templ:
	@templ generate

# Watch commands
watch-templ:
	@templ generate -watch
watch-go:
	@air

# Clean the binary (Windows only)
clean:
	@echo Cleaning...
	@if exist tmp (rmdir /s /q tmp)
	@if exist main.exe (del /f main.exe)
	@for /r %%i in (*_templ.*) do del "%%i"

.PHONY: all templ build clean watch-templ watch-go
