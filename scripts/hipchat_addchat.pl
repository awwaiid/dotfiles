# hipchat_addchat.pl - (c) 2014 Brock Wilcox <awwaiid@thelackthereof.org>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#    * Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# About
# =====
#
# Adds a handy way to join hipchat chat channels.
#
# To use
# ======
#
# 2. /script load hipchat_addchan.pl
#
# 3. /addchat blah_123@blah.conf.hipchat.com #channame
#
# If not given, channel_name will be based off of the room name.

use strict;

use Irssi;

my $VERSION = '1.0';
my %IRSSI = (
	authors => 'Brock Wilcox',
	contact => 'awwaiid@thelackthereof.org',
	name => 'hipchat_addchat',
	description => 'Add a hipchat chat',
	license => 'BSD',
);

Irssi::command_bind hipchat_addchat => sub {
  my ($data, $server, $witem) = @_;
  my ($conf, $chan) = split(/\s+/, $data);
  $chan ||= ($conf =~ /^([^@]+)/);
  if($witem->{type} eq "CHANNEL") {
    $witem->command("MSG ".$witem->{name}." chat add hipchat $conf $chan");
    $witem->command("MSG ".$witem->{name}." channel $chan set nick 'Brock Wilcox'");
    $witem->command("MSG ".$witem->{name}." channel $chan set auto_join true");
  }
};
