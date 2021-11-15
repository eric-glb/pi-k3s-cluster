info: 
	@echo "\nRun 'make deploy' in order to run the cluster configuration playbook."
	@echo "\nEnsure that the 'inventory' file corresponds to your infrastructure and"
	@echo "that your ssh public key has been deployed on the target servers before"
	@echo "running anything!\n"




deploy:
	ansible-playbook cluster.yml
	scp -q pinode0:~/.kube/config ~/.kube/config 
	@sleep 3
	@echo "\nkubectl get nodes -A"
	@echo "--------------------"
	@kubectl get nodes -A
	@echo "\nkubectl get pods -A"
	@echo "-------------------"
	@kubectl get pods -A
	@echo "\nkubectl top node"
	@echo "----------------"
	@kubectl top node
	@echo "\nkubectl top pod -A"
	@echo "------------------"
	@kubectl top pod -A
	@echo ""
