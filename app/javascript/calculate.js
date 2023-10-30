window.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const totalInput = document.getElementById("profit");
  const tax = 0.1
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value
    addTaxDom.innerHTML = Math.floor(inputValue * tax)
    totalInput.innerHTML = Math.floor(inputValue - addTaxDom.innerHTML )

  })
});