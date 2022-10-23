SPLIT = $(subst -, ,$@)
COMPONENT = $(word 2, $(SPLIT))
FILE = insert.scad
TARGET = bad-company-insert.zip

all: money_top tick_down heist_cards small_cards components components_optional
	@echo Done!

zip: clean all
	zip $(TARGET) dist/*.stl LICENSE

money_top: box-money_top lid-money_top
tick_down: box-tick_down
heist_cards: box-heist_cards lid-heist_cards
small_cards: box-small_cards lid-small_cards
components: box-components lid-components
components_optional: box-components_optional
dist: 
	mkdir -p dist

lid-%: dist
	openscad -D "g_isolated_print_box=\"$(COMPONENT)\"" -D "g_b_print_lid=true" -D "g_b_print_box=false" -D "g_lid_solid=true" -o dist/$(COMPONENT)-lid-solid.stl $(FILE)
	openscad -D "g_isolated_print_box=\"$(COMPONENT)\"" -D "g_b_print_lid=true" -D "g_b_print_box=false" -D "g_lid_solid=false" -o dist/$(COMPONENT)-lid.stl $(FILE)

box-%: dist
	openscad -D "g_isolated_print_box=\"$(COMPONENT)\"" -D "g_b_print_lid=false" -D "g_b_print_box=true" -o dist/$(COMPONENT)-box.stl $(FILE)

clean:
	rm -f dist/*.stl $(TARGET)