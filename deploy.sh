docker build -t xenonpluton/multi-client:latest -t xenonpluton/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t xenonpluton/multi-server:latest -t xenonpluton/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t xenonpluton/multi-worker:latest -t xenonpluton/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push xenonpluton/multi-client:latest
docker push xenonpluton/multi-server:latest
docker push xenonpluton/multi-worker:latest

docker push xenonpluton/multi-client:$SHA
docker push xenonpluton/multi-server:$SHA
docker push xenonpluton/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=xenonpluton/multi-server:$SHA
kubectl set image deployments/client-deployment client=xenonpluton/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=xenonpluton/multi-worker:$SHA