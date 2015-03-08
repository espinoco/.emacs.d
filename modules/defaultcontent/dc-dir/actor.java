
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.g2d.Batch;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.scenes.scene2d.Actor;
import com.badlogic.gdx.scenes.scene2d.InputEvent;
import com.badlogic.gdx.scenes.scene2d.InputListener;
import com.badlogic.gdx.scenes.scene2d.Touchable;

public class @BASEFILENAMELESSEXTENSION@ extends Actor {

    private Sprite sprite;

    public @BASEFILENAMELESSEXTENSION@(Sprite sprite) {
        this.sprite = sprite;
        setPosition(250, 250);
        setTouchable(Touchable.enabled);
        setWidth(sprite.getWidth());
        setHeight(sprite.getHeight());
        setBounds(0, 0, getWidth(), getHeight());
        addListener(new InputListener() {
            @Override
            public boolean touchDown(InputEvent event, float x, float y, int pointer, int button) {
                Gdx.app.log("ACTOR", "TOUCH DOWN");
                return true;
            }

            @Override
            public void touchUp(InputEvent event, float x, float y, int pointer, int button) {
                Gdx.app.log("ACTOR", "TOUCH UP");
            }
        });
    }

    @Override
    public void draw(Batch batch, float parentAlpha) {
        batch.draw(sprite, getX(), getY());
    }

}
