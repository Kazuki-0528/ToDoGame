<template>
  <div>
    <v-col class="extra-explain" cols="12" sm="12" md="12" lg="12">
    <h1 v-if="countHiddenPage >= 5">あなたのために祈ってます。</h1>
      <img class="girl" src="../assets/mon_214.gif" />
      <v-icon
        id="call"
        :color="color"
        @click="countCall()"
        class="mb-5 call"
        :size="size"
        >mdi-christianity-outline</v-icon
      >
      <h1 v-if="countHiddenPage >= 10">あなたならやりとげられます</h1>
      <div class="instead-of-form">
        <vue-typer
          style="font-family: dot;"
          :text="[
            'ゆうしゃさま。 さいごまで　よんで　くださいますのね？',
            'ああ！わたしのことばを　きいてくださるかたが　いらっしゃるなんて！',
            'じゅうじかをおして　わたしのことばを',
            'きいてください、、、。'
          ]"
          erase-style="clear"
          :type-delay="140"
          :erase-delay="270"
          :repeat="Infinity"
          caret-animation="expand"
        ></vue-typer>
      </div>
    </v-col>
    <v-col class="extra-explain" cols="12" sm="12" md="12" lg="12">
    <h1>使い方の説明</h1>
    <br>
    <p>今日のやるべきことを登録しよう</p>
    <br>
    <p>TP = タスクポイントだよ</p>
    <br>
    <p>報酬はタスクポイントで購入できるよ</p>
    <br>
    <p>レベルを上げて報酬をゲットしよう！</p>
    </v-col>
  </div>
</template>

<script>
import { VueTyper } from "vue-typer";
export default {
  components: {
    "vue-typer": VueTyper
  },
  data() {
    return {
      color: "",
      size: 65,
      countHiddenPage: 0
    };
  },
  fetch({ store, redirect }) {
    store.watch(
      state => state.currentUser,
      (newUser, oldUser) => {
        if (!newUser) {
          return redirect("/login");
        }
      }
    );
  },
  methods: {
    countCall() {
      this.countHiddenPage++;
      this.size += 10;
      this.color = "blue";
    }
  }
};
</script>

<style lang="scss">
$main-color: #03a9f5 !important;
$sub-color: rgb(11, 214, 236) !important;

.extra-explain {
  text-align: center;
  flex-direction: column;
  .girl {
    height: 60%;
    margin-top: 40px;
  }
}

.vue-typer {
  font-size: 20px;
  letter-spacing: 10px;
}

.vue-typer .custom.char {
  color: white;
  background-color: #252424;
}
.vue-typer .custom.char.selected {
  background-color: #087df1;
}

.vue-typer .custom.caret {
  width: 10px;
  background-color: $main-color;
}

.blue {
  color: blue;
}
</style>
