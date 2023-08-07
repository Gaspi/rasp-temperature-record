INSTALL_FOLDER=/media/NASHDD1/Server/temperature-record

CRON_FILE=/etc/cron.daily/rasp-temperature-record
LOG_FOLDER=$(INSTALL_FOLDER)/logs
DATA_FOLDER=$(INSTALL_FOLDER)/data

# Compile with "make Q=" to display the commands that are run.
Q = @

LOCAL_SRC = $(shell find ./ -type f -name '*.js' -o -name '*.css' -o -name '*.html' -o -name '*.py')
DIST_SRC = $(patsubst ./%, $(INSTALL_FOLDER)/%, $(LOCAL_SRC))

.PHONY: all install uninstall reinstall clear-data
all: install

install: $(INSTALL_FOLDER)/ $(DIST_SRC) $(DATA_FOLDER) $(CRON_FILE)
	$(Q)mkdir -m 775 -p "$(LOG_FOLDER)"
	$(Q)rm -rf "$(LOG_FOLDER)/*"
	$(Q)echo "Installation terminée !"

uninstall:
	$(Q)rm -f "$(CRON_FILE)"
	$(Q)find "$(INSTALL_FOLDER)" -maxdepth 1 -type f -delete
	$(Q)rm -rf "$(LOG_FOLDER)"
	$(Q)echo "Désinstallation terminée !"

clear-data:
	$(Q)rm -rf "$(DATA_FOLDER)"
	$(Q)echo "Données supprimées !"

reinstall: uninstall install

$(INSTALL_FOLDER)/%: %
	$(Q)mkdir -m 775 -p "$(@D)"
	$(Q)cp "$<" "$@"
	$(Q)chmod a+rx "$@"

$(CRON_FILE): cron.sh
	$(Q)mkdir -m 775 -p "$(@D)"
	$(Q)sed "s+\[INSTALL_FOLDER\]+$(INSTALL_FOLDER)+g" "$<" > "$@"
	$(Q)chmod a+rx "$@"

$(DATA_FOLDER):
	$(Q)mkdir -m 775 -p "$@"
	$(Q)chmod -r a+rx "$@"
