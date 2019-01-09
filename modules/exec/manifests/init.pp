define exec::multi ( $commands ) {
$commands.each |$item| {
  exec { $item:
        path   => ["/usr/bin", "/usr/sbin","/bin","/usr/local/sbin","/usr/local/bin"],
        try_sleep => 10,
        logoutput => true,
  }
}

}

