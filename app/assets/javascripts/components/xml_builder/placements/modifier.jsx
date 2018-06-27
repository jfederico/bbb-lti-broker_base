XmlBuilder.Placements.Modifier = React.createClass({
    render: function() {
        if (this.props.type == 'select') {
            (
                <XmlBuilder.Placements.MessageChoice messages={ messages } title={ this.props.children } placementKey={ this.props.placementKey }/>
            )
        }
        if (this.props.messages) {
            var messages = this.props.messages;
            var title = this.props.title
            return (
                <select name={ this.props.placementKey + '_message_type' } >
                    {messages.map(function(message){
                        return (<option name={ title + '  Message Type' } value={ message } >{ message }</option>);
                    })}
                </select>
            );
        } else {
            return false;
        }
    }
});

XmlBuilder.Placements.Modifier title={ this.props.children } placementKey={ this.props.placementKey } type={ this.props.type } envelope={ envelope }
