<<<<<<< HEAD

# 🌩️ Cloud Architecture Lab

Welcome to **Cloud Architecture Lab** – a hands-on collection of projects, utilities, and notes tailored for cloud-native engineers, platform builders, and interview preparation. This repository showcases practical design patterns, DevOps automation, and system architecture examples.

## 🔧 What's Inside

### 📌 1. Sample Projects
- **Multi-Tenant Microservices System (Java + Spring Boot + Kafka)**  
  A simplified backend system showing tenant isolation, async communication via Kafka, and scalable REST endpoints.

- **Cloud-Native App with AWS Lambda + EventBridge**  
  Demonstrates event-driven design, decoupling, and serverless architecture patterns.

---

### 📦 2. Reusable Terraform Modules
- **EKS + Fargate Module**  
  Production-ready Terraform module to bootstrap secure, scalable Kubernetes clusters using Fargate on AWS.

- **Secret Rotation Utility**  
  Template to implement Secrets Manager with auto-rotation and IAM access controls.

---

### ☁️ 3. AWS Utilities Toolkit
- Cloud backup templates (EBS snapshot automation)
- SSM automation scripts
- Secret rotation flows

---

### 📚 4. Interview Notes & Cheatsheets
- `aws-well-architected.md` – Breakdown of AWS WAF pillars
- `java-design-patterns.md` – Key Java patterns & concurrency concepts
- `system-design-questions.md` – Common architecture questions with diagrams
- `observability.md` – Logging, metrics, tracing cheat sheet

---

## 👤 About
Maintained by **Ravi Ranjan Kumar** – Principal Engineer | Platform Architect | AWS + Java Expert.  
🔗 [LinkedIn](https://www.linkedin.com/in/ravikumar6/) • [GitHub](https://github.com/RaviK)

---

## 🛠️ Contributions
Feel free to fork, use, or suggest improvements via pull requests. Let's build better systems together!

=======
Here is a concise and informative `README.md` for your public Spring Boot multi-tenant project. It covers project overview, setup, usage, and contribution guidelines.

---

# Multi-Tenant Spring Boot Application

A sample Spring Boot application demonstrating multi-tenancy using PostgreSQL schemas. This project provides RESTful APIs for tenant management and dynamic schema creation.

## Features

- Multi-tenant architecture with PostgreSQL schemas
- CRUD operations for tenants via REST API
- Dynamic schema creation for each tenant
- Spring Data JPA integration

## Technologies

- Java 17+
- Spring Boot
- Spring Data JPA
- PostgreSQL
- Gradle
- Docker

## Getting Started

### Prerequisites

- Java 17 or higher
- Gradle
- Docker

### Setup

1. **Clone the repository:**
   ```
   git clone https://github.com/your-username/multi-tenant-spring-boot.git
   cd multi-tenant-spring-boot
   ```

2. **Start PostgreSQL using Docker Compose:**
   ```
   docker-compose up -d
   ```

3. **Configure database connection in `application.properties`:**
   ```
   spring.datasource.url=jdbc:postgresql://localhost:5432/postgres
   spring.datasource.username=admin
   spring.datasource.password=admin123
   ```

4. **Build and run the application:**
   ```
   ./gradlew bootRun
   ```

## API Endpoints

| Method | Endpoint                | Description                |
|--------|------------------------ |---------------------------|
| POST   | `/api/tenants`          | Create a new tenant        |
| GET    | `/api/tenants`          | List all tenants           |
| GET    | `/api/tenants/{id}`     | Get tenant by ID           |
| PUT    | `/api/tenants/{id}`     | Update tenant              |
| DELETE | `/api/tenants/{id}`     | Delete tenant              |

## Contributing

Contributions are welcome! Please open issues or submit pull requests for improvements.

## License

This project is licensed under the MIT License.

---
