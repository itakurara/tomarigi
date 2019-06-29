window.onload = function() {
  var status = document.getElementById('js-toggle-by-status');

  function toggleElements() {
    var els = document.querySelectorAll('.js-toggle-element');
    var inputs = document.querySelectorAll('.js-toggle-input');

    els.forEach(function(el) { el.classList.toggle('js-toggle-show'); });
    inputs.forEach(function(input) {
      if (input.getAttribute('disabled') == null) {
        input.setAttribute('disabled', 'disabled');
      } else {
        input.removeAttribute('disabled');
      }
    })
  }

  status.onchange = toggleElements;
}
