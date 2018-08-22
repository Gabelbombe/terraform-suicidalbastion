SHELL 			:= /bin/bash
CHDIR_SHELL := $(SHELL)

define chdir
   $(eval _D=$(firstword $(1) $(@D)))
   $(info $(MAKE): cd $(_D)) $(eval SHELL = cd $(_D); $(CHDIR_SHELL))
endef

STATE_DIR 			= ../_state
LOGS_DIR				= ../_logs

DEPLOYMENT_KEY  = deployment
JUMPBOX_KEY		  = jumpbox

DEPLOYMENT_PATH = ssh/$(DEPLOYMENT_KEY)
JUMPBOX_PATH		= ssh/$(JUMPBOX_KEY)

DEPLOYMENT_PEM  = $(DEPLOYMENT_PATH).pem
JUMPBOX_PEM			= $(JUMPBOX_PATH).pem

AWS_ID?=default

clean:
	@rm -f logs/graph.png
	@rm -rf .terraform

set_opts: .PHONY
  $(aws profile=$(AWS_ID) sts get-caller-identity --output text --query 'Account')

graph:
	terraform graph |dot -Tpng >| logs/graph.png


.check-region:
	@if test "$(REGION)" = "" ; then echo "REGION not set"; exit 1; fi

.check-sshdir: .source-dir
	@[ ! -d 'ssh' ] && { mkdir -p ssh ; } || echo -e '[info] SSH Dir exists...'
	@[ ! -f "$(DEPLOYMENT_PEM)" ] && { 																							\
		ssh-keygen -t rsa -C "$(DEPLOYMENT_KEY)" -P '' -f $(DEPLOYMENT_PATH) -b 1024; \
		mv $(DEPLOYMENT_PATH) $(DEPLOYMENT_PEM) ; chmod 400 $(DEPLOYMENT_PEM) 			  \ 																								 ; \
	} || echo -e '[info] Deployment key exists...'
	@[ ! -f "$(JUMPBOX_PEM)" ] && {																								  \
		ssh-keygen -t rsa -C "$(JUMPBOX_KEY)" -P '' -f $(JUMPBOX_PATH) -b 1024 		  ; \
		mv $(JUMPBOX_PATH) $(JUMPBOX_PEM) 			; chmod 400 $(JUMPBOX_PEM)  				  \																									 ; \
	} || echo -e '[info] Jumpbox key exists...'

.source-dir:
	$(call chdir, src)


###############################################
# Deploy
# - follows standard design patterns
###############################################
plan-jumpbox: .source-dir .check-region .check-sshdir
	echo -e "\n\n\n\nplan-jumpbox: $(date +"%Y-%m-%d @ %H:%M:%S")\n" \
	>> $(LOGS_DIR)/init.log
	terraform init 2>&1 |tee $(LOGS_DIR)/init.log
	echo -e "\n\n\n\nplan-jumpbox: $(date +"%Y-%m-%d @ %H:%M:%S")\n" \
	>> $(LOGS_DIR)/plan.log
	terraform plan 																	\
		-state=$(STATE_DIR)/${REGION}-jumpbox.tfstate \
		-var region="${REGION}" 											\
	2>&1 |tee $(LOGS_DIR)/plan.log


apply-jumpbox: .source-dir .check-region .check-sshdir
	echo -e "\n\n\n\napply-jumpbox: $(date +"%Y-%m-%d @ %H:%M:%S")\n" \
	>> $(LOGS_DIR)/init.log
	terraform init 2>&1 |tee $(LOGS_DIR)/init.log
	echo -e "\n\n\n\napply-jumpbox: $(date +"%Y-%m-%d @ %H:%M:%S")\n" \
	>> $(LOGS_DIR)/apply.log
	terraform apply -auto-approve										\
		-state=$(STATE_DIR)/${REGION}-jumpbox.tfstate \
		-var region="${REGION}" 											\
	2>&1 |tee $(LOGS_DIR)/apply.log


destroy-jumpbox: .source-dir .check-region
	echo -e "\n\n\n\ndestroy-jumpbox: $(date +"%Y-%m-%d @ %H:%M:%S")\n" \
	>> $(LOGS_DIR)/destroy.log
	terraform destroy 															\
		-auto-approve																	\
		-state=$(STATE_DIR)/${REGION}-jumpbox.tfstate \
		-var region="${REGION}" 											\
	2>&1 |tee $(LOGS_DIR)/destroy.log


purge-jumpbox: destroy-jumpbox clean
	@rm -f  $(STATE_DIR)/${REGION}-jumpbox.tfstate
	@rm -fr ssh
