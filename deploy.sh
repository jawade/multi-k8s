docker build -t jawade/multi-client:latest -t jawade/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jawade/multi-server:latest -t jawade/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jawade/multi-worker:latest -t jawade/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jawade/multi-client:latest
docker push jawade/multi-server:latest
docker push jawad/multi-worker:latest

docker push jawade/multi-client:$SHA
docker push jawade/multi-server:$SHA
docker push jawad/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jawade/multi-server:$SHA
kubectl set image deployments/client-deployment client=jawade/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jawade/multi-worker:$SHA