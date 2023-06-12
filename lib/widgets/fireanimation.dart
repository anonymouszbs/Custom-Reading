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
   
    @import url(https://fonts.googleapis.com/css?family=Concert+One);

h1 {
  animation:glow 10s ease-in-out infinite;
  
  

/* For less laggy effect, uncomment this:
  
  animation:none;
  -webkit-text-stroke:1px #fff; 
  
=========== */
  
}



* { box-sizing:border-box; }

body {
  // background:#0a0a0a;
  overflow:hidden;
  text-align:center;
}

figure {
  animation:wobble 5s ease-in-out infinite;
  transform-origin:center center;
  transform-style:preserve-3d;
}

@keyframes wobble {
  0%,100%{ transform:rotate3d(1,1,0,10deg); }
  25%{ transform:rotate3d(-1,1,0,10deg); }
  50%{ transform:rotate3d(-1,-1,0,10deg); }
  75%{ transform:rotate3d(1,-1,0,10deg); }
}

h1 {
  display:block;
  width:50%;
 top:200px;
        right: 0;
  line-height:1.5;
  font:600 3em 'Concert One', sans-serif;
  text-transform:uppercase;
  position:absolute;
  color:#0a0a0a;
}

@keyframes glow {
  0%,100%{ text-shadow:0 0 30px red; }
  25%{ text-shadow:0 0 30px red; }
  50%{ text-shadow:0 0 30px red; }
  75%{ text-shadow:0 0 30px cyan; }
}

h1:nth-child(2){ transform:translateZ(5px); }
h1:nth-child(3){ transform:translateZ(10px);}
h1:nth-child(4){ transform:translateZ(15px); }
h1:nth-child(5){ transform:translateZ(20px); }
h1:nth-child(6){ transform:translateZ(25px); }
h1:nth-child(7){ transform:translateZ(30px); }
h1:nth-child(8){ transform:translateZ(35px); }
h1:nth-child(9){ transform:translateZ(40px); }
h1:nth-child(10){ transform:translateZ(45px); }
  </style>
</head>

<body>
  <canvas id="canvas"></canvas>
    <figure>
  <h1>严守保密记录</br></br>筑牢保密防线</h1>
  <h1>严守保密记录</br></br>筑牢保密防线</h1>
  <h1>严守保密记录</br></br>筑牢保密防线</h1>
 
</figure>
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
