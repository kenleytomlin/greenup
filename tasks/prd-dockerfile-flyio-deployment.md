# PRD: Configure Dockerfile and Deployment Pipeline for Fly.io

## Introduction/Overview

This feature implements the core containerization and deployment configuration for the Greening Bot application using Docker and Fly.io. The goal is to create the foundational Dockerfile and fly.toml configuration files that enable manual deployment of the Elixir Phoenix application to Fly.io.

The Greening Bot is a trading bot that requires WebSocket connections to external APIs, background job processing via GenServers, and persistent database connectivity. The deployment configuration must support these requirements while maintaining simplicity and cost efficiency.

## Goals

1. **Containerization**: Create optimized Dockerfile for Elixir Phoenix application deployment
2. **Fly.io Configuration**: Generate production-ready fly.toml with proper resource allocation
3. **Application Support**: Support Phoenix LiveView, GenServer background processes, PostgreSQL connectivity, and WebSocket connections
4. **Cost Optimization**: Configure minimal resource allocation to reduce operational costs  
5. **Security**: Enable HTTPS termination and prepare for secure secret management
6. **Database Integration**: Configure PostgreSQL integration via Fly.io addon

## User Stories

**As a developer**, I want a properly configured Dockerfile, so that I can build and deploy the application consistently to any environment.

**As a developer**, I want a fly.toml configuration file, so that I can deploy the application to Fly.io with appropriate resource allocation and settings.

**As a system administrator**, I want the deployment configuration to support all application requirements (WebSockets, GenServers, database), so that the bot functions correctly in production.

**As a budget-conscious stakeholder**, I want cost-optimized resource configuration, so that operational expenses are minimized while maintaining functionality.

## Functional Requirements

1. **Dockerfile Configuration**
   1.1. Create optimized Dockerfile for Elixir Phoenix application
   1.2. Support multi-stage build to minimize final image size
   1.3. Include all runtime dependencies (PostgreSQL client, SSL certificates)
   1.4. Configure proper user permissions and security hardening
   1.5. Set appropriate EXPOSE ports for Phoenix application
   1.6. Configure proper entrypoint for Phoenix releases

2. **fly.toml Configuration**
   2.1. Generate fly.toml configuration file for production deployment
   2.2. Configure smallest available instance size (shared-cpu-1x) to minimize costs
   2.3. Set up database connection configuration for Fly.io Postgres addon
   2.4. Enable HTTPS termination with automatic SSL certificate management
   2.5. Configure health check endpoint for application monitoring
   2.6. Set appropriate port configuration for Phoenix LiveView WebSockets
   2.7. Configure environment variables structure for secrets management

3. **Application Runtime Configuration**
   3.1. Configure Phoenix application for production release mode
   3.2. Set up database connection pooling for production environment
   3.3. Enable WebSocket support for Phoenix LiveView connections
   3.4. Configure SSL/TLS settings for external API connections
   3.5. Set up logging configuration for Fly.io environment

## Non-Goals (Out of Scope)

- CI/CD pipeline automation or GitHub Actions integration
- Automated deployment triggers or workflows
- Database migration automation or rollback logic
- Health monitoring and automatic rollback systems
- Multi-environment configuration (staging, development)
- Auto-scaling or load balancing configuration
- Advanced security features (IP allowlisting, VPN, etc.)
- Performance optimization or caching layers
- Backup/restore automation beyond Fly.io addon defaults
- Geographic distribution or multi-region deployment

## Design Considerations

**Dockerfile Design**: Use official Elixir Alpine Linux base image for minimal size. Implement multi-stage build separating compilation and runtime environments.

**Resource Allocation**: Start with shared-cpu-1x (1GB RAM) instance to minimize costs, with ability to scale up if needed.

**Database**: Utilize Fly.io Postgres addon in same region as application for low latency and simplified networking.

**Secrets Management**: Store all sensitive configuration (API keys, database credentials) in Fly.io secrets, accessed via environment variables.

## Technical Considerations

**Dependencies**: 
- Docker BuildKit for optimized multi-stage builds
- Phoenix releases for production deployment
- Fly.io CLI for manual deployment commands
- PostgreSQL client libraries for database connectivity

**Constraints**:
- Must support WebSocket connections for Phoenix LiveView and external APIs
- GenServer processes must be configurable for production supervision
- Database connection must be resilient to network interruptions
- External API connections (Smarkets) require proper SSL/TLS support
- Container must run as non-root user for security

**Integration Points**:
- Fly.io Postgres addon for database connectivity
- Phoenix application configuration system
- Fly.io secrets management for environment variables
- Docker registry integration for image storage

## Success Metrics

1. **Configuration Completeness**: Dockerfile and fly.toml successfully build and deploy the application
2. **Resource Efficiency**: Application runs on shared-cpu-1x instance (1GB RAM) without performance issues
3. **Cost Efficiency**: Monthly hosting costs under $20 for single instance + database
4. **Functionality**: All application features work correctly (LiveView, GenServers, WebSocket connections)
5. **Developer Experience**: Manual deployment process completes with simple `fly deploy` command
6. **Build Performance**: Docker image builds complete within 5 minutes using multi-stage approach

## Implementation Notes

**Dockerfile Structure**: Use multi-stage build with Elixir Alpine base image for compilation and minimal runtime image for deployment.

**fly.toml Configuration**: Configure shared-cpu-1x instances with 1GB RAM and enable WebSocket support for Phoenix LiveView.

**Database Configuration**: Use Fly.io Postgres addon with connection pooling configured for production workloads.

**Security Settings**: Container runs as non-root user with appropriate file permissions and SSL/TLS enabled for external connections.

**Port Configuration**: Expose port 4000 for Phoenix application with proper HTTP/WebSocket handling in fly.toml. 