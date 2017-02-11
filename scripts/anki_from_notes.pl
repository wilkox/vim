#!/usr/bin/perl

my $notesFile = shift;

die unless open(IN, "<", $notesFile);
die unless open(BASIC, ">", "/Users/wilkox/tmp/basic.csv");
die unless open(CLOZE, ">", "/Users/wilkox/tmp/cloze.csv");
while (readline IN) {

  # Catch tags
  if ($. == 2) {
    next unless /@/;
    s/@//g;
    my @tags = split(/\s+/, $_);
    say BASIC "tags: @tags";
    say CLOZE "tags: @tags";
  }

  # Only bullets become flash cards
  next unless /^-/;

  # Strip bullets
  s/^-\s//;
  
  # Strip newlines
  chomp;

  # Note order of precedence: question mark > colon > square brackets

  # If the bullet contains a question mark, it's in 'question' format
  if (/\?/) {

    # Split fields
    my @card = split(/\?/, $_);

    # Cards in this format should only have two fields
    unless (scalar @card == 2) {
      warn("Skipping multi-field card at line $.");
      next;
    }

    # Add to output
    say BASIC "$card[0]?\t$card[1]"

  # If the bullet contains a colon, it's in 'definition' format
  } elsif (/:/) {

    # Split fields
    my @card = split(/:/, $_);

    # Cards in this format should only have two fields
    unless (scalar @card == 2) {
      warn("Skipping multi-field card at line $.");
      next;
    }

    $card[1] =~ s/^\s//;

    # Add to output, including reverse, unless the definition is an acronym in
    # which case no reverse card is created
    say BASIC "Define: $card[0]\t$card[1]";
    say BASIC "What term is defined ‘$card[1]’?\t$card[0]" unless $card[0] =~ /^[A-Z0-9\-]$/;

  # If the bullet contains square brackets, it's in 'cloze' format
  } elsif (/\[/) {

    # Convert to Anki cloze format
    s/\]/\}\}/g;
    my $ii = 1;
    s/\[/"{{c".$ii++."::"/ge;
    say CLOZE $_, "\t";

  # If none of these, emit a warning and skip
  } else {
    warn("Could not determine type of card at line $., skipping");
    next;
  }

}
close IN;
close BASIC;
close CLOSE;

print "Flashcards made";
