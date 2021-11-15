.PHONY : info deploy run_playbook get_kube_config test all

all: info

info: 
	@echo "\nRun 'make deploy' in order to run the cluster configuration playbook."
	@echo "\nEnsure that the 'inventory' file corresponds to your infrastructure and"
	@echo "that your ssh public key has been deployed on the target servers before"
	@echo "running anything!\n"

deploy: | run_playbook get_kube_config test

run_playbook:
	ansible-playbook cluster.yml

get_kube_config:
	scp -q pinode0:~/.kube/config ~/.kube/config 
	@sleep 3

test:
	@echo "\nkubectl get nodes"
	@echo "-----------------"
	@kubectl get nodes
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

