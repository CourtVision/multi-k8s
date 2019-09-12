docker build -t courtvision/multi-client:latest -t courtvision/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t courtvision/multi-server:latest -t courtvision/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t courtvision/multi-worker:latest -t courtvision/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push courtvision/multi-client:latest
docker push courtvision/multi-server:latest
docker push courtvision/multi-worker:latest

docker push courtvision/multi-client:$SHA
docker push courtvision/multi-server:$SHA
docker push courtvision/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=courtvision/multi-server:$SHA
kubectl set image deployments/client-deployment client=courtvision/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=courtvision/multi-worker:$SHA