var Roller = Ember.Application.create({
    LOG_TRANSITIONS: true,
    LOG_BINDINGS: true,
    LOG_VIEW_LOOKUPS: true,
    LOG_STACKTRACE_ON_DEPRECATION: true,
    LOG_VERSION: true,
    debugMode: true
});

Roller.Roll = Ember.Object.extend({
    diceNumber: 0,
    totalRolls: 0,
    numberOfRolls: 0,

    proportion: function() {
        var width = 50 + parseInt(400 * this.get("numberOfRolls") / 
            this.get("totalRolls"));
        return "width: " + width + "px;";
    }.property("totalRolls", "numberOfRolls")
});

Roller.Router.map(function () { 
    this.resource("roll");
});

Roller.RollRoute = Ember.Route.extend({
    model: function () {
        // in a data driven application this could be used 
        // to get information from a server.  Here we just 
        // declare an empty array in memory
        return [Roller.Roll.create(), Roller.Roll.create(), Roller.Roll.create()];
    },

    setupController: function(controller, model) {
        controller.set("content", model);
    }
});

Roller.IndexRoute = Ember.Route.extend({
    redirect: function () {
        this.transitionTo("roll");
    }
});

Roller.RollController = Ember.Controller.extend({
    rollDice: function () {
        var roll = this.get("rollString"),
            content = [],
            rolls = 0, 
            sides = 0,
            errors = "",
            i, rnd, roll_parts;

        // check if anything was typed in the text box
        if (roll === undefined) {
            this.set("errors", "Please fill out the text box!");
            return
        }

        // split up the string around the 'd' 
        roll_parts = roll.split("d");

        if (roll_parts.length !== 2) {
            // check if we had a "d" in our text (i.e. its correctly formatted)
            errors += "You need to enter a value in the format 'xdy'.  ";
        } else {
            // then split up and parse the required numbers
            rolls = parseInt(roll_parts[0]);
            sides = parseInt(roll_parts[1]);

            if (isNaN(rolls) || isNaN(sides)) {
                errors += "Rolls and sides must be numbers.  ";
            }

            // generate the dice rolls if we haven't found any errors
            if (errors.length === 0) {
                // generate all the models
                for (i = 0; i < sides; i++) {
                    content.push(Roller.Roll.create({
                        diceNumber: i + 1,
                        totalRolls: rolls
                    }));
                }

                // now roll all the dice
                for (i = 0; i < rolls; i++) {
                    // roll a dice
                    rnd = Math.floor(Math.random() * sides);

                    // increment the required model
                    content[rnd].incrementProperty("numberOfRolls");
                }
            }
        }

        // update the content
        this.set("content", content);

        // display any errors
        this.set("errors", errors);
    }
});