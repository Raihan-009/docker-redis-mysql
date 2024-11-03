mysql:
	docker build -t mysql-app -f Dockerfile.mysql .
	docker run -d --name mysql-container --network myapp-network -p 3306:3306 mysql-app
	@echo "Deploying MySQL"

redis:
	docker build -t redis-app -f Dockerfile.redis .
	docker run -d --name redis-container --network myapp-network -p 6379:6379 redis-app
	@echo "Deploying Redis"

backend:
	docker build -t backend-app -f Dockerfile.backend .
	docker run -d --name backend-container --network myapp-network -p 8000:8000 backend-app
	@echo "Deploying API server at http://localhost:8000"

clean:
	docker stop mysql-container redis-container backend-container
	docker rm mysql-container redis-container backend-container
	docker network rm myapp-network

all: mysql redis backend
