#!/usr/bin/perl
use File::Copy;

my $notesFile = shift;

die unless open(IN, "<", $notesFile);
die unless open(BASIC, ">", "/Users/wilkox/tmp/basic.csv");
die unless open(CLOZE, ">", "/Users/wilkox/tmp/cloze.csv");
die unless open(DEFINITION, ">", "/Users/wilkox/tmp/definition.csv");
while (readline IN) {

  # Catch tags
  if ($. == 2) {
    next unless /@/;
    s/@//g;
    my @tags = split(/\s+/, $_);
    say BASIC "tags: @tags";
    say CLOZE "tags: @tags";
    say DEFINITION "tags: @tags";
  }

  # Only bullets become flash cards
  next unless /^-/;

  # Strip bullets
  s/^-\s//;

  # Strip newlines
  chomp;

  # Note order of precedence: question mark > colon > square brackets

  # Catch images and replace with html img links
  # Check that media folder is still in the correct place
  my $mediaFolder = '/Users/wilkox/Library/Application Support/Anki2/Medicine/collection.media';
  die "Anki media folder could no longer be found at $mediaFolder" unless -d $mediaFolder;
  if (/\!\[([^\]]+)\]/) {
    my $match = $&;
    my $img = $1;

    # Check image exists
    my $imgOldPath = "/Users/wilkox/Documents/study_images/$img.png";
    die "Could not find image at $imgOldPath" unless -e $imgOldPath;

    # Copy image to Anki media folder
    my $imgNewPath = "$mediaFolder/$img.png";
    copy($imgOldPath, $imgNewPath) or die "Copy failed";

    # Put new path in img tag
    my $imgTag = "<p><img src='$imgNewPath' alt='$img'></p>";
    $_ =~ s/\Q$match/$imgTag/;
  }

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

    # Add to output
    say DEFINITION "$card[0]\t$card[1]";

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
close DEFINITION;

print "Flashcards made";
