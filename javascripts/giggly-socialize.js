
Giggly = function(gigyaConfig) {
	
	this.config = gigyaConfig;
	
	this.connect = function(provider, onSuccess, onFailure, useFacebookConnect, context) {
		var params = {
			'provider': provider,
			'callback': _onSuccessOrFailure(onSuccess, onFailure),
			'context' : context,
			'useFacebookConnect' : useFacebookConnect
		};
		return gigya.services.socialize.connect(this.config, params);  
	};
	
	this.login = function(provider, redirect, onSuccess, onFailure, useFacebookConnect, context) {
		var params = {
			'provider': provider,
			'context' : context,
			'useFacebookConnect' : useFacebookConnect
		};
		if (null != redirect && null != onSuccess) {
			console.warn('The onSuccess and onFailure params will be ignored if passed in with redirect.');
		}
		if (null == redirect) {
			params['callback'] = _onSuccessOrFailure(onSuccess, onFailure);
		} else {
			params['redirect'] = redirect;
		}
		return gigya.services.socialize.login(this.config, params);
	};
	
	this.isLoggedIn = function(onSuccess, onFailure, context) {
		var params = {
			'context' : context,
			'callback': _onSuccessOrFailure(onSuccess, onFailure)
		};
		return gigya.services.socialize.isLoggedIn(this.config, params);
	};
	
	this.logout = function(onSuccess, onFailure, context) {
		var params = {
			'context' : context,
			'callback': _onSuccessOrFailure(onSuccess, onFailure)
		};
		return gigya.services.socialize.logout(this.config, params);
	};
	
	this.getUserInfo = function(onSuccess, onFailure, context) {
		var params = {
			'context' : context,
			'callback': _onSuccessOrFailure(onSuccess, onFailure)
		};
		return gigya.services.socialize.getUserInfo(this.config, params);
	};
	
	this.addEventHandlers = function(onLogin, onConnect, onDisconnect, onSuccess, onFailure, context) {
		var params = {
			'context' : context,
			'callback': _onSuccessOrFailure(onSuccess, onFailure)
		};
		if ('function' == typeof onLogin) { params['onLogin'] = onLogin; }
		if ('function' == typeof onConnect) { params['onConnect'] = onConnect; }
		if ('function' == typeof onDisconnect) { params['onDisconnect'] = onDisconnect; }
		return gigya.services.socialize.addEventHandlers(this.config, params);
	};
	
	this.disconnect = function(provider, onSuccess, onFailure, context) {
		var params = {
			'provider': provider,
			'context' : context,
			'callback': _onSuccessOrFailure(onSuccess, onFailure)
		};
		return gigya.services.socialize.disconnect(this.config, params);
	};
	
	// currently supported capabilities are: login, notifications, actions, friends, status
	this.getAvailableProviders = function(requiredCapabilities, onSuccess, onFailure, context) {
		if ('string' != typeof requiredCapabilities) {
			requiredCapabilities = 'login,notifications,actions,friends,status';
		}
		var params = {
			'callback': _onSuccessOrFailure(onSuccess, onFailure),
			'context' : context,
			'requiredCapabilities' : requiredCapabilities
		};
		return gigya.services.socialize.getAvailableProviders(this.config, params);
	};
	
	var _onSuccessOrFailure = function(success, failure) {
		var onSuccessOrFailure = function(response) {
			if ('OK' == response.status) {
				if ('function' == typeof success) {
					success(response);
				} else {
					console.log(response);
				}
			} else {
				if ('function' == typeof failure) {
					failure(response);
				} else {
					console.error("An error has occurred! Error details: (" + response.statusMessage + ") In method: " + response.operation);
				}
			}
		};
		return onSuccessOrFailure;
	};
	
}