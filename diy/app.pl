#!/var/lib/openshift/57f7b04189418bd3240007bd/app-root/data/perl-new/bin/perl

use Dancer2;

get '/' => sub {
  my $err;
  template 'index.tt', {
    'err' => $err,
  };
};

get '/hello/:name' => sub {
  return "Why, hello there " . params->{name};
};

get '/envs' => sub {
  my $self = shift;
  my ($key, $envstring);
  for $key (sort keys %ENV){
    $envstring .= "$key : $ENV{$key}<br>\n";
  }
  return $envstring;
};

dance;

