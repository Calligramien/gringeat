const displayDiv = () => {
  const hide = document.querySelector(".hide");
  const ingredients = document.getElementById("ingredients");
  if (hide) {
    ingredients.addEventListener('click', event => {
      hide.classList.toggle('show');
    })
  };
}

export { displayDiv }

