
import com.badlogic.gdx.graphics.g2d.Batch;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.scenes.scene2d.Actor;
import com.badlogic.gdx.scenes.scene2d.InputEvent;
import com.badlogic.gdx.scenes.scene2d.InputListener;
import com.badlogic.gdx.scenes.scene2d.Touchable;

public class @BASEFILENAMELESSEXTENSION@ extends Actor {

    private Sprite sprite;
    private Sprite touchedSprite;
    private boolean isTouched;

    public @BASEFILENAMELESSEXTENSION@(Sprite sprite, Sprite touchedSprite) {
        this.sprite = sprite;
        this.touchedSprite = touchedSprite;
        isTouched = false;
        setPosition(250, 250);
        setTouchable(Touchable.enabled);
        setWidth(sprite.getWidth());
        setHeight(sprite.getHeight());
        setBounds(0, 0, getWidth(), getHeight());
        addListener(new InputListener() {
            @Override
            public boolean touchDown(InputEvent event, float x, float y, int pointer, int button) {
                isTouched = true;
                return true;
            }

            @Override
            public void touchUp(InputEvent event, float x, float y, int pointer, int button) {
                isTouched = false;
            }
        });
    }

    @Override
    public void draw(Batch batch, float parentAlpha) {
        if (isTouched)
            batch.draw(touchedSprite, getX(), getY());
        else
            batch.draw(sprite, getX(), getY());
    }

}
