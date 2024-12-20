# Inception

Inception is a project inspired by the need to understand Docker and containerization. It challenges you to build a multi-container environment, with services such as NGINX, WordPress, MariaDB, and more, all orchestrated using Docker Compose.

## Overview

The goal of this project was to create an entire web application environment using Docker Compose. Each service runs in its own container, and they all communicate through an internal network. The environment includes:

- NGINX for serving as a reverse proxy.
- MariaDB as the database service.
- WordPress for content management.
- Redis for caching.
- A static site service.

This project helped me master Docker fundamentals, container orchestration, and networking. By leveraging Docker Compose, I could isolate each service and ensure seamless communication between them.

## Compile and Run

### Clone the Repository
```bash
git clone https://github.com/antonioldev/inception.git
```

### Prepare the Environment
1. Ensure Docker and Docker Compose are installed.
2. Clone the repository to your local machine.
3. Navigate to the project directory.

### Build and Start All Containers
To prepare and start all containers, run:
```bash
make all
```

This will:
- Build all necessary images.
- Start the containers for NGINX, WordPress, MariaDB, Redis, and the static site.

After the containers are up and running, you only need to create a WordPress admin user to finalize the setup.

### Accessing the Environment
- The WordPress site will be accessible via the domain configured in your NGINX container.
- The static site service is available within the internal network.

### Stop All Containers
To stop and remove all running containers, use:
```bash
make clean
```

## Bonus Part

The bonus part includes additional services like Redis for caching and a static site service. The static site is served from an internal container without exposing any external ports. This demonstrates the flexibility of Docker Compose in managing complex environments.

## My Experience

This project was an incredible journey into the world of Docker. It was my introduction to building scalable and isolated environments that can run seamlessly on any system.

Inception taught me the importance of containerization in modern development. Each service operates independently yet communicates effortlessly through Docker networking. It was rewarding to see how these containers can replicate a real-world production environment.

From configuring services like NGINX and WordPress to writing Dockerfiles for custom containers, this project sharpened my skills in:
- Managing containerized services.
- Using Docker Compose for orchestration.
- Configuring internal and external networks.

This project is a testament to the power of containerization and how it can simplify complex environments. Feel free to explore the codebase, and maybe it will inspire you to start your own containerization journey!

---

Happy exploring, and let me know if you add any exciting features or configurations to the Inception project!

