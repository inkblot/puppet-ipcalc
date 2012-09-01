class ipcalc {
	package { 'ruby-ip':
		provider => gem,
		ensure   => installed,
	}
}
