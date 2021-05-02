docker build -t cgiardin6d3947/multi-client:latest -t cgiardin6d3947/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cgiardin6d3947/multi-server:latest -t cgiardin6d3947/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cgiardin6d3947/multi-worker:latest -t cgiardin6d3947/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cgiardin6d3947/multi-client:latest
docker push cgiardin6d3947/multi-server:latest
docker push cgiardin6d3947/multi-worker:latest

docker push cgiardin6d3947/multi-client:$SHA
docker push cgiardin6d3947/multi-server:$SHA
docker push cgiardin6d3947/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=cgiardin6d3947/multi-client:$SHA
kubectl set image deployments/server-deployment server=cgiardin6d3947/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=cgiardin6d3947/multi-worker:$SHA