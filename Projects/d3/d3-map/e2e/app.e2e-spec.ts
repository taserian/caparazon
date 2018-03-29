import { D3MapPage } from './app.po';

describe('d3-map App', () => {
  let page: D3MapPage;

  beforeEach(() => {
    page = new D3MapPage();
  });

  it('should display welcome message', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('Welcome to app!!');
  });
});
