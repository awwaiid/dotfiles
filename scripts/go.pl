use strict;
use vars qw($VERSION %IRSSI);
use Irssi;
use Irssi::Irc;

# Usage:
# /script load go.pl
# If you are in #irssi you can type /go #irssi or /go irssi or even /go ir ...
# also try /go ir<tab> and /go  <tab> (that's two spaces)

$VERSION = '1.00';

%IRSSI = (
    authors     => 'nohar',
    contact     => 'nohar@freenode',
    name        => 'go to window',
    description => 'Implements /go command that activates a window given a name/partial name. It features a nice completion.',
    license     => 'GPLv2 or later',
    changed     => '08-17-04'
);

sub get_windows {
  my @windows = Irssi::windows();
  @windows = sort {
    $b->{data_level} <=> $a->{data_level}
    || $b->{last_line} <=> $a->{last_line}
  } @windows;
  return @windows;
}


sub signal_complete_go {
	my ($complist, $window, $word, $linestart, $want_space) = @_;
	my $channel = $window->get_active_name();
	my $k = Irssi::parse_special('$k');

        return unless ($linestart =~ /^\Q${k}\Ego/i);

	@$complist = ();
  # my @windows = Irssi::windows();
  # @windows = sort { $a->get_active_name cmp $b->get_active_name } @windows;
  # @windows = sort { $b->{data_level} <=> $a->{data_level} || $b->{last_line} <=> $a->{last_line} } @windows;
  # @windows = sort {
    # $b->{data_level} <=> $a->{data_level}
    # # || ($b->get_active_name =~ /optoro/) <=> ($a->get_active_name =~ /optoro/)
    # || $b->{last_line} <=> $a->{last_line}
  # } @windows;
  my @windows = get_windows();
	foreach my $w (@windows) {
		my $name = $w->get_active_name();
		if ($word ne "") {
			if ($name =~ /\Q${word}\E/i) {
				push(@$complist, $name)
			}
		} else {
			push(@$complist, $name);
		}
	}
	Irssi::signal_stop();
};

sub cmd_go
{
	my($chan,$server,$witem) = @_;

	$chan =~ s/ *//g;

  # Let's have a consistent order for the windows based on the name
  my @windows = get_windows();

  # No channel given? Just jump to the next @window
  if($chan eq '') {
    $windows[0]->set_active();
    return;
  }

  # Look for it exactly
	foreach my $w (@windows) {
		my $name = $w->get_active_name();
		if ($name =~ /^#?\Q${chan}\E$/i) {
			$w->set_active();
			return;
		}
	}

  # Next look for it as a prefix
	foreach my $w (@windows) {
		my $name = $w->get_active_name();
		if ($name =~ /^#?\Q${chan}\E/i) {
			$w->set_active();
			return;
		}
	}

  # If not found that way, look for it in the middle
	foreach my $w (@windows) {
		my $name = $w->get_active_name();
		if ($name =~ /\Q${chan}\E/i) {
			$w->set_active();
			return;
		}
	}
}

Irssi::command_bind("go", "cmd_go");
Irssi::signal_add_first('complete word', 'signal_complete_go');

