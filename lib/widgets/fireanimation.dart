
const fireanimation = '''
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <title>Fire Particle Animation</title>
  <style>
    html,
    body {
      margin: 0;
      padding: 0;
    }

    canvas {
      width: 100%;
      height: 100%;
      position: fixed;
      top: 0;
      left: 0;
      z-index: -1;
    }
  </style>
</head>

<body>
  <canvas id="canvas"></canvas>
  <script>
    const canvas = document.getElementById('canvas');
    const ctx = canvas.getContext('2d');

    // 设置画布大小
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    let particles = [];

    class FireParticle {
      constructor(x, y) {
        this.x = x;
        this.y = y;
        this.size = Math.random() * 2 + 2;
        this.alpha = 1.0;
        this.drift = Math.random() > 0.5 ? -10 : 10;
        this.speed = Math.random() * 80 + 80;
      }

      update(dt) {
        this.alpha -= dt * 0.5;
        if (this.alpha < 0) {
          this.alpha = 0;
        }
        this.x += dt * this.speed;
        this.y -= dt * this.speed;
        this.x += this.drift * dt;
      }

      render() {
        const gradient = ctx.createRadialGradient(this.x, this.y, 0, this.x, this.y, this.size);
        gradient.addColorStop(0, 'rgba(255, 211, 0, ' + this.alpha + ')');
        gradient.addColorStop(0.5, 'rgba(255, 165, 0, ' + this.alpha + ')');
        gradient.addColorStop(1, 'rgba(255, 88, 0, ' + this.alpha + ')');
        ctx.fillStyle = gradient;
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.size, 0, 2 * Math.PI);
        ctx.fill();
      }
    }

    function update(dt) {
      particles.forEach(p => {
        p.update(dt);
      });
      particles.push(new FireParticle(Math.random() * (canvas.width), canvas.height + Math.random() * 1000));
      particles = particles.filter(p => p.alpha > 0);
    }

    function render() {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      particles.forEach(p => {
        p.render();
      });
    }

    // 更新和渲染
    let lastTime = 0;

    function loop(timestamp) {
      const dt = (timestamp - lastTime) / 2000;
      update(dt);
      render();
      lastTime = timestamp;
      requestAnimationFrame(loop);
    }

    // 启动动画
    requestAnimationFrame(loop);

    // 监听窗口大小变化，重新设置画布大小
    window.addEventListener('resize', () => {
      canvas.width = window.innerWidth;
      canvas.height = window.innerHeight;
    });
  </script>
</body>

</html>

''';