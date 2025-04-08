package main

import (
	"context"
	"fmt"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/docker/docker/api/types"
	"github.com/docker/docker/api/types/filters"
	"github.com/docker/docker/client"
	"github.com/gorilla/mux"
	"github.com/sirupsen/logrus"
)

var log = logrus.New()

func init() {
	log.SetFormatter(&logrus.TextFormatter{
		FullTimestamp: true,
	})
	log.SetOutput(os.Stdout)
	log.SetLevel(logrus.InfoLevel)
}

func main() {
	log.Info("Starting Transcribulator Protocol Handler")

	// Create Docker client
	cli, err := client.NewClientWithOpts(client.FromEnv, client.WithAPIVersionNegotiation())
	if err != nil {
		log.Fatalf("Failed to create Docker client: %v", err)
	}
	defer cli.Close()

	// Create router
	r := mux.NewRouter()
	r.HandleFunc("/health", healthCheckHandler).Methods("GET")
	r.HandleFunc("/services", getServicesHandler(cli)).Methods("GET")
	r.HandleFunc("/register", registerProtocolHandler).Methods("POST")

	// Create server
	srv := &http.Server{
		Addr:         ":8080",
		Handler:      r,
		ReadTimeout:  10 * time.Second,
		WriteTimeout: 10 * time.Second,
		IdleTimeout:  120 * time.Second,
	}

	// Start server in a goroutine
	go func() {
		log.Info("Server listening on :8080")
		if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			log.Fatalf("Failed to start server: %v", err)
		}
	}()

	// Wait for interrupt signal
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c

	// Shutdown server gracefully
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	if err := srv.Shutdown(ctx); err != nil {
		log.Fatalf("Server shutdown failed: %v", err)
	}
	log.Info("Server gracefully stopped")
}

func healthCheckHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	fmt.Fprintf(w, "OK")
}

func getServicesHandler(cli *client.Client) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		ctx := context.Background()
		
		// Get containers with transcribulator labels
		filters := filters.NewArgs()
		filters.Add("label", "transcribulator.protocol=true")
		
		containers, err := cli.ContainerList(ctx, types.ContainerListOptions{
			Filters: filters,
		})
		
		if err != nil {
			log.Errorf("Failed to list containers: %v", err)
			http.Error(w, "Failed to list services", http.StatusInternalServerError)
			return
		}
		
		// Return container information
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		
		fmt.Fprintf(w, "{\n  \"services\": [\n")
		for i, container := range containers {
			serviceName := container.Labels["transcribulator.service"]
			fmt.Fprintf(w, "    {\n      \"id\": \"%s\",\n      \"name\": \"%s\"\n    }", 
				container.ID[:12], serviceName)
			if i < len(containers)-1 {
				fmt.Fprintf(w, ",")
			}
			fmt.Fprintf(w, "\n")
		}
		fmt.Fprintf(w, "  ]\n}")
	}
}

func registerProtocolHandler(w http.ResponseWriter, r *http.Request) {
	// This would register the protocol handler with the operating system
	// Implementation depends on the OS and is beyond the scope of this example
	w.WriteHeader(http.StatusNotImplemented)
	fmt.Fprintf(w, "Protocol handler registration not implemented")
}
