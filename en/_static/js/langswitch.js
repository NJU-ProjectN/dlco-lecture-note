document.addEventListener("DOMContentLoaded", function() {
  // Add a language switcher dropdown
  const switcher = document.createElement("div");
  switcher.innerHTML = `
    <select id="lang-switcher">
      <option value="en">English</option>
      <option value="zh">中文</option>
    </select>
  `;
  switcher.style.position = "fixed";
  switcher.style.top = "10px";
  switcher.style.right = "10px";
  switcher.style.zIndex = "9999";
  document.body.appendChild(switcher);

  const selector = document.getElementById("lang-switcher");
  selector.value = localStorage.getItem("lang") || "en";
  applyLang(selector.value);

  selector.addEventListener("change", function() {
    const lang = this.value;
    localStorage.setItem("lang", lang);
    applyLang(lang);
  });

  function applyLang(lang) {
    if (lang === "en") {
      document.querySelectorAll("[id$=_cn]").forEach(el => el.style.display = "none");
      document.querySelectorAll("a[href*=_cn]").forEach(el => el.parentElement.style.display = "none");
      document.querySelectorAll("[id]:not([id$=_cn])").forEach(el => el.style.display = "");
    } else {
      document.querySelectorAll("[id$=_cn]").forEach(el => el.style.display = "");
      document.querySelectorAll("a[href*=_cn]").forEach(el => el.parentElement.style.display = "");
      document.querySelectorAll("[id]:not([id$=_cn])").forEach(el => el.style.display = "none");
    }
  }
});
