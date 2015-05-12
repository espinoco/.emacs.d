package

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.graphics.g2d.TextureAtlas;
import com.badlogic.gdx.scenes.scene2d.Stage;
import com.badlogic.gdx.utils.viewport.StretchViewport;

import mx.ujed.escueladelenguas.EnglishTaleGame;
import mx.ujed.escueladelenguas.GameScreen;
import mx.ujed.escueladelenguas.ScreenUtils;

public class @BASEFILENAMELESSEXTENSION@ extends GameScreen {

    final EnglishTaleGame game;
    private Sprite background;
    private TextureAtlas atlas;
    private Stage stage;

    public @BASEFILENAMELESSEXTENSION@(final EnglishTaleGame game) {
        this.game = game;
        background = ScreenUtils.getDefaultScreenBackground();
        prepareScreen();
    }

    public void loadAssetsPack() {
    }

    @Override
    public void render(float delta) {
        Gdx.gl.glClearColor(0, 0, 0, 0);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);

        game.batch.begin();

        game.batch.disableBlending();
        background.draw(game.batch);
        game.batch.enableBlending();

        game.batch.end();

        game.batch.begin();

        stage.act(delta);
        stage.draw();

        game.batch.end();
    }

    @Override
    public void show() {
        Gdx.input.setCatchMenuKey(true);

        stage = new Stage(new StretchViewport(800, 480));
        Gdx.input.setInputProcessor(stage);
    }

    @Override
    public void hide() {

    }

    @Override
    public void pause() {

    }

    @Override
    public void resume() {

    }

    @Override
    public void resize(int width, int height) {
        stage.getViewport().update(width, height, false);
    }

    @Override
    public void dispose() {
        atlas = null;
    }

}
