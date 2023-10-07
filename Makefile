INSTALL_FOLDER = /media/NASHDD1/Server/temperature-record

CRON_FILE = /etc/cron.d/temperature-record
LOG_FOLDER = $(INSTALL_FOLDER)/logs

# Compile with "make Q=" to display the commands that are run.
Q = @

LOCAL_SRC = $(shell find ./ -type f -name '*.py')
DIST_SRC = $(patsubst ./%, $(INSTALL_FOLDER)/%, $(LOCAL_SRC))

.PHONY: all install uninstall reinstall cleardata
all: install

install: $(DIST_SRC) $(DATA_FOLDER) $(CRON_FILE)
	$(Q)mkdir -m 775 -p "$(LOG_FOLDER)"
	$(Q)rm -rf "$(LOG_FOLDER)/*"
	$(Q)echo "Installation terminée !"

uninstall:
	$(Q)rm -f "$(CRON_FILE)"
	$(Q)find "$(INSTALL_FOLDER)" -maxdepth 1 -type f -delete
	$(Q)rm -rf "$(LOG_FOLDER)"
	$(Q)echo "Désinstallation terminée !"

cleardata:
	$(Q)rm -rf "$(DATA_FOLDER)"
	$(Q)echo "Données supprimées !"

reinstall: uninstall install

$(INSTALL_FOLDER)/%: %
	$(Q)mkdir -m 775 -p "$(@D)"
	$(Q)cp "$<" "$@"
	$(Q)chmod a+rx "$@"

$(CRON_FILE): cron
	$(Q)mkdir -m 775 -p "$(@D)"
	$(Q)sed "s+\[INSTALL_FOLDER\]+$(INSTALL_FOLDER)+g" "$<" | sed "s+\[LOG_FOLDER\]+$(LOG_FOLDER)+g" > "$@"
	$(Q)chmod a+rx "$@"
