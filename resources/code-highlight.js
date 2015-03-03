function highlight() {
	var currentSlide, currentFragments, prevSlideData = null;

	var forEach = function(array, callback) {
		var i = -1, length = array ? array.length : 0;
		while (++i < length) {
			callback(array[i]);
		}
	};

	Reveal.addEventListener('ready', function(e) {
		updateCurrent(e);
		init();
	});

	function init() {
		var hljs_nodes = document.querySelectorAll('pre code');

		for (var i = 0, len = hljs_nodes.length; i < len; i++) {
			var element = hljs_nodes[i];

			// Trim whitespace if the `data-trim` attribute is present.
			if (element.hasAttribute('data-trim') && typeof element.innerHTML.trim == 'function') {
				element.innerHTML = element.innerHTML.trim();
			}

			// Escape HTML unless prevented by author.
			if (!element.hasAttribute('data-noescape')) {
				element.innerHTML = element.innerHTML.replace(/</g,"&lt;").replace(/>/g,"&gt;");
			}

			// Highlight code using highlight.js.
			hljs.highlightBlock(element);

			// Split highlighted code into lines.
			element.innerHTML = '<span class=line>' + element.innerHTML.replace(/\n/g, '</span><span class=line>') + '</span>';
		}

		Reveal.addEventListener('slidechanged', updateCurrent);

		Reveal.addEventListener('fragmentshown', function(e) {
			highlightFragment(e.fragment);
		});

		Reveal.addEventListener('fragmenthidden', function(e) {
			var i = Array.prototype.indexOf.call(currentFragments, e.fragment);
			if (i == 0) {
				clearPreviousHighlights();
			} else {
				highlightFragment(currentFragments[i - 1]);
			}
		});
	}

	function updateCurrent(e) {
		currentSlide = e.currentSlide;
		currentFragments = currentSlide.getElementsByClassName('fragment');
		clearPreviousHighlights();
		if (currentFragments.length) {
			if (prevSlideData && (prevSlideData.indexh > e.indexh || (prevSlideData.indexh == e.indexh && prevSlideData.indexv > e.indexv))) {
				forEach(currentFragments, function(fragment) {
					fragment.classList.add('visible');
				});
				currentFragments[currentFragments.length - 1].classList.add('current-fragment');
				highlightFragment(currentFragments[currentFragments.length - 1]);
			}
		}
		prevSlideData = {
			'indexh': e.indexh,
			'indexv': e.indexv
		};
	}

	function clearPreviousHighlights() {
		forEach(currentSlide.querySelectorAll('pre code .line.highlight'), function(line) {
			line.classList.remove('highlight');
		});
	}

	function highlightFragment(fragment) {
		clearPreviousHighlights();
		var lines = fragment.getAttribute('data-code-highlight');
		if (lines) {
			lines = lines.split('-');
			var code = currentSlide.querySelectorAll('pre code .line');
			if (lines.length == 1) {
				code[lines[0] - 1].classList.add('highlight');
			} else {
				var i = lines[0], j = lines[1];
				i--;
				while (++i <= j) {
					code[i - 1].classList.add('highlight');
				}
			}
		}
	}
}
