function formatUptime(seconds) {
      const h = Math.floor(seconds / 3600);
      const m = Math.floor((seconds % 3600) / 60);
      const s = Math.floor(seconds % 60);
      
      const parts = [];
      if (h > 0) parts.push(`${h}h`);
      if (m > 0 || h > 0) parts.push(`${m}m`);
      parts.push(`${s}s`);
      
      return parts.join(' ');
    }

    async function fetchInfo() {
      try {
        const response = await fetch('/api/info');
        if (!response.ok) throw new Error('Network response was not ok');
        const data = await response.json();
        
        // Update values
        const statusEl = document.getElementById('app-status');
        const statusBadge = statusEl.parentElement;
        statusEl.textContent = data.status || 'ONLINE';
        statusBadge.classList.remove('offline');
        
        document.getElementById('app-platform').textContent = data.platform || 'AWS ECS Fargate';
        document.getElementById('app-region').textContent = data.region || 'us-east-1';
        
        // Setup direct update for uptime to make it live count up between polls
        let currentUptime = Math.floor(data.uptime || 0);
        document.getElementById('app-uptime').textContent = formatUptime(currentUptime);
        
        if (window.uptimeInterval) clearInterval(window.uptimeInterval);
        window.uptimeInterval = setInterval(() => {
          currentUptime++;
          document.getElementById('app-uptime').textContent = formatUptime(currentUptime);
        }, 1000);

      } catch (error) {
        console.error('Error fetching system info:', error);
        const statusEl = document.getElementById('app-status');
        if (statusEl) {
          statusEl.textContent = 'OFFLINE';
          statusEl.parentElement.classList.add('offline');
        }
      }
    }

    // Initial fetch and poll every 10 seconds
    fetchInfo();
    setInterval(fetchInfo, 10000);