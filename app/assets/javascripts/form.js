window.onload = function() {
  var statusSelect = document.getElementById('js-toggle-by-status');
  var statusRadio = document.getElementsByClassName('js-toggle-by-status');

  if (statusSelect) { statusSelect.onchange = toggleElements; }
  if (statusRadio) {
    for(var i = 0; i < statusRadio.length; i++){
      radio = statusRadio.item(i);
      radio.onchange = toggleElements;
    }
  }

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
}
