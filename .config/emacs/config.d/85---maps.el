;;; -*- lexical-binding: t; -*-

; * opemstreetmap
; ** general config
(use-package osm
  :general (general-def-leader
            "r m" 'sk:osm-home)

  :init
  (add-hook 'osm-mode-hook #'(lambda () (visual-line-mode -1) (setq-local truncate-lines t)))

  (defun sk:osm-home ()
    (interactive)
    (let ((display-buffer-overriding-action '(display-buffer-same-window)))
      (osm-home)))

  :config
  ;; (setq osm-default-server 'default)
  (setq osm-default-zoom 15)
  (setq osm-copyright nil)
  (setq osm-home '(49 8.4 12))

; ** map servers
; *** google maps
  (osm-add-server 'google-maps-roads
    :name "Google Maps Roads"
    :description "Google Maps Roads"
    :url "https://mt0.google.com/vt/lyrs=m&x=%x&y=%y&z=%z"
    :max-connections 16
    :ext 'png
    :group "Google Maps")
  (osm-add-server 'google-maps-hybrid
    :name "Google Maps Hybrid"
    :description "Google Maps Hybrid"
    :url "https://mt0.google.com/vt/lyrs=y&x=%x&y=%y&z=%z"
    :max-connections 16
    :ext 'jpeg
    :group "Google Maps")
  (osm-add-server 'google-maps-satellite
    :name "Google Maps Satellite"
    :description "Google Maps Sattelite"
    :url "https://mt0.google.com/vt/lyrs=s&x=%x&y=%y&z=%z"
    :max-connections 16
    :ext 'jpeg
    :group "Google Maps")
  (osm-add-server 'google-maps-terrain
    :name "Google Maps Terrain"
    :description "Google Maps Terrain"
    :url "https://mt0.google.com/vt/lyrs=p&x=%x&y=%y&z=%z"
    :ext 'jpeg
    :group "Google Maps")

; *** opentopomap
  (osm-add-server 'opentopomap
    :name "OpenTopoMap"
    :description "OpenTopoMap"
    :url "https://tile.opentopomap.org/%z/%x/%y.png"
    :max-connections 16
    :group "Special Purpose")

; *** openrailwaymap
  (osm-add-server 'openrailwaymap-standard
    :name "OpenRailwayMap Standard"
    :description "OpenRailwayMap Standard"
    :url "https://tiles.openrailwaymap.org/standard/%z/%x/%y.png"
    :max-connections 16
    :group "OpenRailwayMap")
  (osm-add-server 'openrailwaymap-signals
    :name "OpenRailwayMap Signals"
    :description "OpenRailwayMap Signals"
    :url "https://tiles.openrailwaymap.org/signals/%z/%x/%y.png"
    :max-connections 16
    :group "OpenRailwayMap")
  (osm-add-server 'openrailwaymap-maxspeed
    :name "OpenRailwayMap Max Speed"
    :description "OpenRailwayMap Max Speed"
    :url "https://tiles.openrailwaymap.org/maxspeed/%z/%x/%y.png"
    :max-connections 16
    :group "OpenRailwayMap")
  (osm-add-server 'openrailwaymap-electrification
    :name "OpenRailwayMap Electrification"
    :description "OpenRailwayMap Electrification"
    :url "https://tiles.openrailwaymap.org/electrification/%z/%x/%y.png"
    :max-connections 16
    :group "OpenRailwayMap")
  (osm-add-server 'openrailwaymap-gauge
    :name "OpenRailwayMap Gauge"
    :description "OpenRailwayMap Gauge"
    :url "https://tiles.openrailwaymap.org/gauge/%z/%x/%y.png"
    :max-connections 16
    :group "OpenRailwayMap")
  )
