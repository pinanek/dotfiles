function build-bat-cache() {
  log info "Building bat's cache..."
  bat cache --build
  log success "bat's cache is built."
}
