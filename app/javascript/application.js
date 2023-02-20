// Dependencies
import { RalixApp } from 'ralix';
import '@hotwired/turbo-rails';

// Controllers
import AppCtrl from './controllers/app';
import TransactionCtrl from './controllers/transaction';

// Components
import RemoteModal from './components/remote_modal';
import Tooltip from './components/tooltip';

const App = new RalixApp({
  routes: {
    '/transactions': TransactionCtrl,
    '/.*': AppCtrl,
  },
  components: [RemoteModal, Tooltip],
});

App.start();
