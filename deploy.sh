docker build -t shaharkeren/multi-client:latest -t shaharkeren/multi-client:"$SHA" -f ./client/Dockerfile ./client
docker build -t shaharkeren/multi-worker:latest -t shaharkeren/multi-worker:"$SHA" -f ./worker/Dockerfile ./worker
docker build -t shaharkeren/multi-server:latest -t shaharkeren/multi-server:"$SHA" -f ./server/Dockerfile ./server
docker push shaharkeren/multi-client:latest
docker push shaharkeren/multi-worker:latest
docker push shaharkeren/multi-server:latest
docker push shaharkeren/multi-client:"$SHA"
docker push shaharkeren/multi-worker:"$SHA"
docker push shaharkeren/multi-server:"$SHA"
kubectl apply -f ./k8s
kubectl set image deployment/server-deployment server=shaharkeren/multi-server:"$SHA"
kubectl set image deployment/worker-deployment worker=shaharkeren/multi-worker:"$SHA"
kubectl set image deployment/client-deployment client=shaharkeren/multi-client:"$SHA"