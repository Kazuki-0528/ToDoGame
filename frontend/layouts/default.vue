<template>
  <v-app class="app" dark>
    <Success />
    <Loading />
    <div>
      <Loading></Loading>
    </div>
    <v-navigation-drawer
      v-model="drawer"
      :mini-variant="miniVariant"
      :clipped="clipped"
      fixed
      src="https://cdn.vuetifyjs.com/images/backgrounds/bg-2.jpg"
      app
    >
      <v-list>
        <v-list-item
          v-for="(item, i) in items"
          :key="i"
          :to="item.to"
          router
          exact
        >
          <v-list-item-action>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title v-text="item.title" />
          </v-list-item-content>
        </v-list-item>

        <v-list-item v-if="currentUser" @click="logOutWindow = true">
          <v-list-item-action>
            <v-icon>mdi-brightness-3</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>ログアウト</v-list-item-title>
          </v-list-item-content>
          <v-dialog v-model="logOutWindow">
            <v-card>
              <v-card-title class="headline grey lighten-2" color="red">ログアウトしますか？</v-card-title>
              <v-btn color="blue" @click="logOut">はい</v-btn>
              <v-btn color="blue" @click="logOutWindow = false">いいえ</v-btn>
            </v-card>
          </v-dialog>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <v-app-bar class="tool-bar" :clipped-left="clipped" fixed app>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
      <v-toolbar-title class="pl-0">
        <router-link v-if="currentUser" to="/user" class="toolbar-title"
          ><img class="sword" src="../assets/icon002.png" />ToDo<span class="title-first">Game</span></router-link
        >
        <router-link v-else to="/login" class="toolbar-title"
          ><img class="sword" src="../assets/icon002.png" />ToDo<span class="title-first">Game</span></router-link
        >
      </v-toolbar-title>

      <v-toolbar-items class="page-link" v-if="currentUser">
        <v-btn to="/user" class="header-btn ml-1">
          <v-hover v-slot:default="{ hover }">
            <v-icon size="25px" color="blue" v-text="hover ? 'mdi-book-open-page-variant' : 'mdi-book-open-variant'">
            </v-icon>
          </v-hover>
        </v-btn>
      </v-toolbar-items>

      <v-toolbar-items class="page-link" v-if="currentUser">
        <v-btn to="/reward" nuxt class="header-btn ml-2">
          <v-hover v-slot:default="{ hover }">
            <v-icon size="25px" color="red" v-text="hover ? 'mdi-gift' : 'mdi-gift-outline'">
            </v-icon>
          </v-hover>
        </v-btn>
      </v-toolbar-items>

      <v-toolbar-items class="page-link" v-if="currentUser">
        <v-btn to="/" nuxt class="header-btn ml-2">
          <v-hover v-slot:default="{ hover }">
            <v-icon size="25px" color="yellow" v-text="hover ? 'mdi-help-circle' : 'mdi-help-circle-outline'">
            </v-icon>
          </v-hover>
        </v-btn>
      </v-toolbar-items>

      <v-spacer />
    </v-app-bar>
    <v-content>
      <v-container>
        <nuxt />
      </v-container>
    </v-content>
    <v-footer :fixed="fixed" app>
      <span class="footer">素材提供【Rド】様<img class="min-map" src="../assets/icon016.png" /></span>
    </v-footer>
  </v-app>
</template>

<script>
import Loading from "@/components/Loading";
import Success from "@/components/Success";
import firebase from "@/plugins/firebase";
import axios from "@/plugins/axios";

export default {
  data() {
    return {
      clipped: false,
      drawer: false,
      fixed: false,
      miniVariant: false,
      right: false,
      rightDrawer: false,
      title: "ToDoGame",
      logOutWindow: false,
      logoutConfirm: false
    };
  },
  components: {
    Loading,
    Success,
  },
  computed: {
    currentUser() {
      return this.$store.state.currentUser;
    },
    items() {
      if (this.currentUser) {
        return [
          {
            icon: "mdi-book-open-page-variant",
            title: "やること",
            to: "/user"
          },
          {
            icon: "mdi-gift",
            title: "報酬",
            to: "/reward"
          },
          {
            icon: "mdi-help-circle",
            title: "ヘルプ",
            to: "/"
          }
        ];
      } else {
        return [
          {
            icon: "mdi-cat",
            title: "ログイン",
            to: "/login",
          },
          {
            icon: "mdi-hand-heart-outline",
            title: "おまけ",
            to: "/signup"
          }
        ];
      }
    }
  },
  methods: {
    logOut() {
      this.logOutWindow = false;
      firebase
        .auth()
        .signOut()
        .then(() => {
          this.$store.commit("setUser", null);
          this.$router.push("/");
        })
        .catch(error => {
          console.log(error);
        });
    }
  }
};
</script>

<style lang="scss">
$main-color: rgb(11, 214, 236);

$pc: 1024px;
$tab: 680px;
$sp: 480px;

@mixin pc {
  @media (max-width: ($pc)) {
    @content;
  }
}

@mixin tab {
  @media (max-width: ($tab)) {
    @content;
  }
}

@mixin sp {
  @media (max-width: ($sp)) {
    @content;
  }
}

@font-face {
  font-family: dot;
  src: url("../assets/fonts/k8x12S.ttf") format("truetype");
}

.app {
  .toolbar-title {
    color: white;
    text-decoration: none;
    font-family: "dot";
    font-size: 35px;
    letter-spacing: 5px;
    font-weight: bold;
    .title-first {
      color: $main-color;
    }
  }

  .sword {
    padding-right: 10px;
    margin-top: 5px;
  }

  .tool-bar {
    display: flex;
    .title-icon {
      color: $main-color;
    }
  }

  .page-link {
    justify-content: right;

    .page-link-title {
      padding-top: 15%;
    }

    .logout-btn {
      background-color: aquamarine;
      margin: 0 0 0 auto;
    }
  }

  .v-content_wrap {
    background-color: black !important;
  }

  .footer {
    position: relative;
    font-family: dot;
    font-size: 15px;
    letter-spacing: 7px;
    .min-map {
      position: absolute;
    }
  }

  .min-map {
    padding-left: 6px;
  }

  .v-list-item__title {
    font-family: dot;
    font-size: 20px;
    letter-spacing: 5px;
  }
}
</style>
