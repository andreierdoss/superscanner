superscanner
============

Ultimate scanning machine.

In order to see how awesome this scanner is, do the following:

    git clone https://github.com/andreierdoss/superscanner.git
    cd superscanner
    bundle install
    rspec spec

In an production environment rules and items can be saved to the database. By saving the rules, an audit trail can be created for pricing decisions.

The current version unitizes all items according to the pricing rules specified and then it calculates the total.
