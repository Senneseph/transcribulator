use anyhow::Result;
use bollard::Docker;
use std::process::Command;

pub struct ProtocolHandler {
    docker: Docker,
}

impl ProtocolHandler {
    pub fn new() -> Result<Self> {
        let docker = Docker::connect_with_local_defaults()?;
        Ok(Self { docker })
    }

    pub async fn handle_url(&self, url: &str) -> Result<()> {
        // Parse transcribulator:// URL
        let path = url.strip_prefix("transcribulator://")
            .ok_or_else(|| anyhow::anyhow!("Invalid protocol"))?;

        // Find container with matching service label
        let containers = self.docker.list_containers(Some(bollard::container::ListContainersOptions {
            filters: vec![("label", vec!["transcribulator.protocol=true"])],
            ..Default::default()
        })).await?;

        if let Some(container) = containers.first() {
            // Get container port mapping
            let port = self.get_container_port(container)?;
            
            // Open default browser with correct URL
            let url = format!("http://localhost:{}/{}", port, path);
            self.open_browser(&url)?;
        }

        Ok(())
    }

    fn open_browser(&self, url: &str) -> Result<()> {
        #[cfg(target_os = "linux")]
        Command::new("xdg-open").arg(url).spawn()?;

        #[cfg(target_os = "macos")]
        Command::new("open").arg(url).spawn()?;

        #[cfg(target_os = "windows")]
        Command::new("cmd").args(["/C", "start", url]).spawn()?;

        Ok(())
    }
}