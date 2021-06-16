 import "jquery-bar-rating";

const initStarRating = () => {
  $('.reviewrating').barrating({
    theme: 'css-stars'
  });
};

export { initStarRating };
