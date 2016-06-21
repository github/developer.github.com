// before anything happens, check if this is a versionless enterprise URL
path = window.location.pathname;
paths = path.split("/");
if (paths[1] == "enterprise" && (paths[2].length === 0 || isNaN(paths[2]))) {
  paths.splice(2, 0, String({{ site.version }}));
  suffix = window.location.search || window.location.hash;
  window.location.href = window.location.protocol + "//" + window.location.host + paths.join("/") + suffix;
}
