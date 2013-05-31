/* assuan.h - Definitions for the Assuan IPC library
 * Copyright (C) 2001, 2002, 2003, 2005, 2007, 
 *               2008 Free Software Foundation, Inc.
 *
 * This file is part of Assuan.
 *
 * Assuan is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation; either version 2.1 of
 * the License, or (at your option) any later version.
 *
 * Assuan is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this program; if not, see <http://www.gnu.org/licenses/>.
 */

#ifndef ASSUAN_H
#define ASSUAN_H

#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#ifndef _ASSUAN_NO_SOCKET_WRAPPER
#ifdef _WIN32
#include <ws2tcpip.h> 
#else
#include <sys/socket.h>
#endif
#endif /*!_ASSUAN_NO_SOCKET_WRAPPER*/

/* To use this file with libraries the following macros are useful:

     #define _ASSUAN_EXT_SYM_PREFIX _foo_
   
       This prefixes all external symbols with "_foo_".

     #define _ASSUAN_ONLY_GPG_ERRORS

       If this is defined all old-style Assuan error codes are made
       inactive as well as other deprecated stuff.

     #define _ASSUAN_NO_SOCKET_WRAPPER

       Do not include the definitions for the socket wrapper feature.

   The follwing macros are used internally in the implementation of
   libassuan:

     #define _ASSUAN_NO_PTH 

       This avoids inclusion of special GNU Pth hacks.

     #define _ASSUAN_NO_FIXED_SIGNALS 

       This disables changing of certain signal handler; i.e. SIGPIPE.

     #define _ASSUAN_USE_DOUBLE_FORK

       Use a double fork approach when connecting to a server through
       a pipe.
 */


#ifdef _ASSUAN_EXT_SYM_PREFIX
#define _ASSUAN_PREFIX1(x,y) x ## y
#define _ASSUAN_PREFIX2(x,y) _ASSUAN_PREFIX1(x,y)
#define _ASSUAN_PREFIX(x) _ASSUAN_PREFIX2(_ASSUAN_EXT_SYM_PREFIX,x)
#define assuan_ _ASSUAN_PREFIX(assuan_)
#define assuan_register_command _ASSUAN_PREFIX(assuan_register_command)
#define assuan_register_post_cmd_notify \
  _ASSUAN_PREFIX(assuan_register_post_cmd_notify)
#define assuan_register_bye_notify _ASSUAN_PREFIX(assuan_register_bye_notify)
#define assuan_register_reset_notify \
  _ASSUAN_PREFIX(assuan_register_reset_notify)
#define assuan_register_cancel_notify \
  _ASSUAN_PREFIX(assuan_register_cancel_notify)
#define assuan_register_input_notify \
  _ASSUAN_PREFIX(assuan_register_input_notify)
#define assuan_register_output_notify \
  _ASSUAN_PREFIX(assuan_register_output_notify)
#define assuan_register_option_handler \
  _ASSUAN_PREFIX(assuan_register_option_handler)
#define assuan_process _ASSUAN_PREFIX(assuan_process)
#define assuan_process_next _ASSUAN_PREFIX(assuan_process_next)
#define assuan_process_done _ASSUAN_PREFIX(assuan_process_done)
#define assuan_get_active_fds _ASSUAN_PREFIX(assuan_get_active_fds)
#define assuan_get_data_fp _ASSUAN_PREFIX(assuan_get_data_fp)
#define assuan_set_okay_line _ASSUAN_PREFIX(assuan_set_okay_line)
#define assuan_write_status _ASSUAN_PREFIX(assuan_write_status)
#define assuan_command_parse_fd _ASSUAN_PREFIX(assuan_command_parse_fd)
#define assuan_set_hello_line _ASSUAN_PREFIX(assuan_set_hello_line)
#define assuan_accept _ASSUAN_PREFIX(assuan_accept)
#define assuan_get_input_fd _ASSUAN_PREFIX(assuan_get_input_fd)
#define assuan_get_output_fd _ASSUAN_PREFIX(assuan_get_output_fd)
#define assuan_close_input_fd _ASSUAN_PREFIX(assuan_close_input_fd)
#define assuan_close_output_fd _ASSUAN_PREFIX(assuan_close_output_fd)
#define assuan_init_pipe_server _ASSUAN_PREFIX(assuan_init_pipe_server)
#define assuan_deinit_server _ASSUAN_PREFIX(assuan_deinit_server)
#define assuan_init_socket_server _ASSUAN_PREFIX(assuan_init_socket_server)
#define assuan_init_connected_socket_server \
  _ASSUAN_PREFIX(assuan_init_connected_socket_server)
#define assuan_init_socket_server_ext \
  _ASSUAN_PREFIX(assuan_init_socket_server_ext)
#define assuan_pipe_connect _ASSUAN_PREFIX(assuan_pipe_connect)
#define assuan_pipe_connect_ext _ASSUAN_PREFIX(assuan_pipe_connect_ext)
#define assuan_socket_connect _ASSUAN_PREFIX(assuan_socket_connect)
#define assuan_socket_connect_ext _ASSUAN_PREFIX(assuan_socket_connect_ext)
#define assuan_disconnect _ASSUAN_PREFIX(assuan_disconnect)
#define assuan_get_pid _ASSUAN_PREFIX(assuan_get_pid)
#define assuan_get_peercred _ASSUAN_PREFIX(assuan_get_peercred)
#define assuan_transact _ASSUAN_PREFIX(assuan_transact)
#define assuan_inquire _ASSUAN_PREFIX(assuan_inquire)
#define assuan_inquire_ext _ASSUAN_PREFIX(assuan_inquire_ext)
#define assuan_read_line _ASSUAN_PREFIX(assuan_read_line)
#define assuan_pending_line _ASSUAN_PREFIX(assuan_pending_line)
#define assuan_write_line _ASSUAN_PREFIX(assuan_write_line)
#define assuan_send_data _ASSUAN_PREFIX(assuan_send_data)
#define assuan_sendfd _ASSUAN_PREFIX(assuan_sendfd)
#define assuan_receivefd _ASSUAN_PREFIX(assuan_receivefd)
#define assuan_set_malloc_hooks _ASSUAN_PREFIX(assuan_set_malloc_hooks)
#define assuan_set_io_hooks _ASSUAN_PREFIX(assuan_set_io_hooks)
#define assuan_set_log_stream _ASSUAN_PREFIX(assuan_set_log_stream)
#define assuan_set_error _ASSUAN_PREFIX(assuan_set_error)
#define assuan_set_pointer _ASSUAN_PREFIX(assuan_set_pointer)
#define assuan_get_pointer _ASSUAN_PREFIX(assuan_get_pointer)
#define assuan_set_io_monitor _ASSUAN_PREFIX(assuan_set_io_monitor)
#define assuan_begin_confidential _ASSUAN_PREFIX(assuan_begin_confidential)
#define assuan_end_confidential _ASSUAN_PREFIX(assuan_end_confidential)
#define assuan_strerror _ASSUAN_PREFIX(assuan_strerror)
#define assuan_set_assuan_err_source \
  _ASSUAN_PREFIX(assuan_set_assuan_err_source)
#define assuan_set_assuan_log_stream \
  _ASSUAN_PREFIX(assuan_set_assuan_log_stream)
#define assuan_get_assuan_log_stream \
  _ASSUAN_PREFIX(assuan_get_assuan_log_stream)
#define assuan_get_assuan_log_prefix \
  _ASSUAN_PREFIX(assuan_get_assuan_log_prefix)
#define assuan_set_flag _ASSUAN_PREFIX(assuan_set_flag)
#define assuan_get_flag _ASSUAN_PREFIX(assuan_get_flag)
#define assuan_pipe_connect2 _ASSUAN_PREFIX(assuan_pipe_connect2)
#define assuan_set_assuan_log_prefix \
  _ASSUAN_PREFIX(assuan_set_assuan_log_prefix)
#define assuan_sock_close       _ASSUAN_PREFIX(assuan_sock_close)      
#define assuan_sock_new         _ASSUAN_PREFIX(assuan_sock_new)        
#define assuan_sock_connect     _ASSUAN_PREFIX(assuan_sock_connect)    
#define assuan_sock_bind        _ASSUAN_PREFIX(assuan_sock_bind)       
#define assuan_sock_get_nonce   _ASSUAN_PREFIX(assuan_sock_get_nonce)
#define assuan_sock_check_nonce _ASSUAN_PREFIX(assuan_sock_check_nonce)


/* And now the internal functions, argh...  */
#define _assuan_read_line _ASSUAN_PREFIX(_assuan_read_line)
#define _assuan_cookie_write_data _ASSUAN_PREFIX(_assuan_cookie_write_data)
#define _assuan_cookie_write_flush _ASSUAN_PREFIX(_assuan_cookie_write_flush)
#define _assuan_read_from_server _ASSUAN_PREFIX(_assuan_read_from_server)
#define _assuan_domain_init _ASSUAN_PREFIX(_assuan_domain_init)
#define _assuan_register_std_commands \
  _ASSUAN_PREFIX(_assuan_register_std_commands)
#define _assuan_simple_read _ASSUAN_PREFIX(_assuan_simple_read)
#define _assuan_simple_write _ASSUAN_PREFIX(_assuan_simple_write)
#define _assuan_io_read _ASSUAN_PREFIX(_assuan_io_read)
#define _assuan_io_write _ASSUAN_PREFIX(_assuan_io_write)
#define _assuan_io_hooks _ASSUAN_PREFIX(_assuan_io_hooks)
#define _assuan_new_context _ASSUAN_PREFIX(_assuan_new_context)
#define _assuan_release_context _ASSUAN_PREFIX(_assuan_release_context)
#define _assuan_malloc _ASSUAN_PREFIX(_assuan_malloc)
#define _assuan_realloc _ASSUAN_PREFIX(_assuan_realloc)
#define _assuan_calloc _ASSUAN_PREFIX(_assuan_calloc)
#define _assuan_free _ASSUAN_PREFIX(_assuan_free)
#define _assuan_log_print_buffer _ASSUAN_PREFIX(_assuan_log_print_buffer)
#define _assuan_log_sanitized_string \
  _ASSUAN_PREFIX(_assuan_log_sanitized_string)
#define _assuan_log_printf _ASSUAN_PREFIX(_assuan_log_printf)
#define _assuan_set_default_log_stream \
  _ASSUAN_PREFIX(_assuan_set_default_log_stream)
#define _assuan_w32_strerror _ASSUAN_PREFIX(_assuan_w32_strerror)
#define _assuan_gpg_strerror_r _ASSUAN_PREFIX(_assuan_gpg_strerror_r)
#define _assuan_gpg_strsource  _ASSUAN_PREFIX(_assuan_gpg_strsource)
#define _assuan_write_line _ASSUAN_PREFIX(_assuan_write_line)
#define _assuan_error _ASSUAN_PREFIX(_assuan_error)
#define _assuan_error_is_eagain   _ASSUAN_PREFIX(_assuan_error_is_eagain)
#define _assuan_init_uds_io _ASSUAN_PREFIX(_assuan_init_uds_io)
#define _assuan_uds_close_fds _ASSUAN_PREFIX(_assuan_uds_close_fds)
#define _assuan_uds_deinit _ASSUAN_PREFIX(_assuan_uds_deinit)
#define _assuan_simple_recvmsg _ASSUAN_PREFIX(_assuan_simple_recvmsg)
#define _assuan_simple_sendmsg _ASSUAN_PREFIX(_assuan_simple_sendmsg)
#define _assuan_waitpid _ASSUAN_PREFIX(_assuan_waitpid)
#define _assuan_sock_wsa2errno   _ASSUAN_PREFIX(_assuan_sock_wsa2errno)
#define _assuan_sock_close       _ASSUAN_PREFIX(_assuan_sock_close)      
#define _assuan_sock_new         _ASSUAN_PREFIX(_assuan_sock_new)        
#define _assuan_sock_connect     _ASSUAN_PREFIX(_assuan_sock_connect)    
#define _assuan_sock_bind        _ASSUAN_PREFIX(_assuan_sock_bind)       
#define _assuan_sock_get_nonce   _ASSUAN_PREFIX(_assuan_sock_get_nonce)
#define _assuan_sock_check_nonce _ASSUAN_PREFIX(_assuan_sock_check_nonce)

#endif /*_ASSUAN_EXT_SYM_PREFIX*/


#ifdef __cplusplus
extern "C"
{
#if 0
}
#endif
#endif


/* Check for compiler features.  */
#if __GNUC__
#define _ASSUAN_GCC_VERSION (__GNUC__ * 10000 \
                            + __GNUC_MINOR__ * 100 \
                            + __GNUC_PATCHLEVEL__)

#if _ASSUAN_GCC_VERSION > 30100
#define _ASSUAN_DEPRECATED  __attribute__ ((__deprecated__))
#endif
#endif
#ifndef _ASSUAN_DEPRECATED
#define _ASSUAN_DEPRECATED
#endif


/* Assuan error codes.  These are only used by old applications or
   those applications which won't make use of libgpg-error. */
#ifndef _ASSUAN_ONLY_GPG_ERRORS
#ifndef _ASSUAN_IN_LIBASSUAN
#define  ASSUAN_No_Error 0
#endif
#define  ASSUAN_General_Error 1
#define  ASSUAN_Out_Of_Core 2
#define  ASSUAN_Invalid_Value 3
#ifndef _ASSUAN_IN_LIBASSUAN
#define  ASSUAN_Timeout 4
#endif
#define  ASSUAN_Read_Error 5
#define  ASSUAN_Write_Error 6
#define  ASSUAN_Problem_Starting_Server 7
#define  ASSUAN_Not_A_Server 8
#ifndef _ASSUAN_IN_LIBASSUAN
#define  ASSUAN_Not_A_Client 9
#endif
#define  ASSUAN_Nested_Commands 10
#define  ASSUAN_Invalid_Response 11
#define  ASSUAN_No_Data_Callback 12
#define  ASSUAN_No_Inquire_Callback 13
#define  ASSUAN_Connect_Failed 14
#define  ASSUAN_Accept_Failed 15

  /* Error codes above 99 are meant as status codes */
#define  ASSUAN_Not_Implemented 100
#define  ASSUAN_Server_Fault    101
#ifndef _ASSUAN_IN_LIBASSUAN
#define  ASSUAN_Invalid_Command 102
#endif
#define  ASSUAN_Unknown_Command 103
#define  ASSUAN_Syntax_Error    104
#ifndef _ASSUAN_IN_LIBASSUAN
#define  ASSUAN_Parameter_Error 105
#endif
#define  ASSUAN_Parameter_Conflict 106
#define  ASSUAN_Line_Too_Long 107
#define  ASSUAN_Line_Not_Terminated 108
#ifndef _ASSUAN_IN_LIBASSUAN
#define  ASSUAN_No_Input 109
#define  ASSUAN_No_Output 110
#endif
#define  ASSUAN_Canceled 111
#ifndef _ASSUAN_IN_LIBASSUAN
#define  ASSUAN_Unsupported_Algorithm 112
#define  ASSUAN_Server_Resource_Problem 113
#define  ASSUAN_Server_IO_Error 114
#define  ASSUAN_Server_Bug 115
#define  ASSUAN_No_Data_Available 116
#define  ASSUAN_Invalid_Data 117
#endif
#define  ASSUAN_Unexpected_Command 118
#define  ASSUAN_Too_Much_Data 119
#ifndef _ASSUAN_IN_LIBASSUAN
#define  ASSUAN_Inquire_Unknown 120
#define  ASSUAN_Inquire_Error 121
#define  ASSUAN_Invalid_Option 122
#define  ASSUAN_Invalid_Index 123
#define  ASSUAN_Unexpected_Status 124
#define  ASSUAN_Unexpected_Data 125
#define  ASSUAN_Invalid_Status 126
#define  ASSUAN_Locale_Problem 127
#endif
#define  ASSUAN_Not_Confirmed 128

  /* Warning: Don't use the Error codes, below they are deprecated. */
#ifndef _ASSUAN_IN_LIBASSUAN
#define  ASSUAN_Bad_Certificate 201
#define  ASSUAN_Bad_Certificate_Chain 202
#define  ASSUAN_Missing_Certificate 203
#define  ASSUAN_Bad_Signature 204
#define  ASSUAN_No_Agent 205
#define  ASSUAN_Agent_Error 206
#define  ASSUAN_No_Public_Key 207
#define  ASSUAN_No_Secret_Key 208
#define  ASSUAN_Invalid_Name 209

#define  ASSUAN_Cert_Revoked 301
#define  ASSUAN_No_CRL_For_Cert 302
#define  ASSUAN_CRL_Too_Old 303
#define  ASSUAN_Not_Trusted 304

#define  ASSUAN_Card_Error 401
#define  ASSUAN_Invalid_Card 402
#define  ASSUAN_No_PKCS15_App 403
#define  ASSUAN_Card_Not_Present 404
#define  ASSUAN_Invalid_Id 405

  /* Error codes in the range 1000 to 9999 may be used by applications
     at their own discretion. */
#define  ASSUAN_USER_ERROR_FIRST 1000
#define  ASSUAN_USER_ERROR_LAST 9999
#endif

typedef int assuan_error_t;

typedef assuan_error_t AssuanError _ASSUAN_DEPRECATED; 

/* This is a list of pre-registered ASSUAN commands */
/* Note, these command IDs are now deprectated and solely exists for
   compatibility reasons. */
typedef enum
{
  ASSUAN_CMD_NOP = 0,
  ASSUAN_CMD_CANCEL,    /* cancel the current request */
  ASSUAN_CMD_BYE,
  ASSUAN_CMD_AUTH,
  ASSUAN_CMD_RESET,
  ASSUAN_CMD_OPTION,
  ASSUAN_CMD_DATA,
  ASSUAN_CMD_END,
  ASSUAN_CMD_INPUT,
  ASSUAN_CMD_OUTPUT,

  ASSUAN_CMD_USER = 256  /* Other commands should be used with this offset*/
} AssuanCommand;


#else  /*!_ASSUAN_ONLY_GPG_ERRORS*/

typedef int assuan_error_t;

#endif /*!_ASSUAN_ONLY_GPG_ERRORS*/


/* Definitions of flags for assuan_set_flag(). */
typedef enum
  {
    /* When using a pipe server, by default Assuan will wait for the
       forked process to die in assuan_disconnect.  In certain cases
       this is not desirable.  By setting this flag, the waitpid will
       be skipped and the caller is responsible to cleanup a forked
       process. */
    ASSUAN_NO_WAITPID = 1,
    /* This flag indicates whether Assuan logging is in confidential
       mode. Use assuan_{begin,end}_condidential to change the
       mode.  */
    ASSUAN_CONFIDENTIAL = 2
  } 
assuan_flag_t;

#define ASSUAN_LINELENGTH 1002 /* 1000 + [CR,]LF */

struct assuan_context_s;
typedef struct assuan_context_s *assuan_context_t;
#ifndef _ASSUAN_ONLY_GPG_ERRORS
typedef struct assuan_context_s *ASSUAN_CONTEXT _ASSUAN_DEPRECATED;
#endif /*_ASSUAN_ONLY_GPG_ERRORS*/

/* Because we use system handles and not libc low level file
   descriptors on W32, we need to declare them as HANDLE (which
   actually is a plain pointer).  This is required to eventually
   support 64 bit Windows systems.  */
#ifdef _WIN32
typedef void *assuan_fd_t;
#define ASSUAN_INVALID_FD ((void*)(-1))
#define ASSUAN_INT2FD(s)  ((void *)(s))
#define ASSUAN_FD2INT(h)  ((unsigned int)(h))
#else
typedef int assuan_fd_t;
#define ASSUAN_INVALID_FD (-1)
#define ASSUAN_INT2FD(s)  ((s))
#define ASSUAN_FD2INT(h)  ((h))
#endif


/* Assuan features an emulation of Unix domain sockets based on a
   local TCP connections.  To implement access permissions based on
   file permissions a nonce is used which is expected by th server as
   the first bytes received.  This structure is used by the server to
   save the nonce created initially by bind.  On POSIX systems this is
   a dummy operation. */  
struct assuan_sock_nonce_s
{
  size_t length;
#ifdef _WIN32
  char nonce[16];
#endif
};
typedef struct assuan_sock_nonce_s assuan_sock_nonce_t;

/* Define the Unix domain socket structure for Windows.  */
#if defined(_WIN32) && !defined(_ASSUAN_NO_SOCKET_WRAPPER)
#ifndef AF_LOCAL
#define AF_LOCAL AF_UNIX
#endif
#define EADDRINUSE WSAEADDRINUSE
struct sockaddr_un
{
  short          sun_family;
  unsigned short sun_port;
  struct         in_addr sun_addr;
  char           sun_path[108-2-4]; 
};
#endif


/* Definition of hook functions used to conditionally replace the
   default I/O functions. */
struct assuan_io_hooks
{
  int (*read_hook)(assuan_context_t, assuan_fd_t, void *, size_t, ssize_t *);
  int (*write_hook)(assuan_context_t, assuan_fd_t fd,
                    const void *, size_t, ssize_t *);
};
typedef struct assuan_io_hooks *assuan_io_hooks_t;



/*-- assuan-handler.c --*/
int assuan_register_command (assuan_context_t ctx,
                             const char *cmd_string,
                             int (*handler)(assuan_context_t, char *));
int assuan_register_post_cmd_notify (assuan_context_t ctx,
                                     void (*fnc)(assuan_context_t, int));
int assuan_register_bye_notify (assuan_context_t ctx,
                                void (*fnc)(assuan_context_t));
int assuan_register_reset_notify (assuan_context_t ctx,
                                  void (*fnc)(assuan_context_t));
int assuan_register_cancel_notify (assuan_context_t ctx,
                                   void (*fnc)(assuan_context_t));
int assuan_register_input_notify (assuan_context_t ctx,
                                  void (*fnc)(assuan_context_t, const char *));
int assuan_register_output_notify (assuan_context_t ctx,
                                  void (*fnc)(assuan_context_t, const char *));

int assuan_register_option_handler (assuan_context_t ctx,
                                    int (*fnc)(assuan_context_t,
                                               const char*, const char*));

int assuan_process (assuan_context_t ctx);
int assuan_process_next (assuan_context_t ctx);
int assuan_process_done (assuan_context_t ctx, int rc);
int assuan_get_active_fds (assuan_context_t ctx, int what,
                           assuan_fd_t *fdarray, int fdarraysize);


FILE *assuan_get_data_fp (assuan_context_t ctx);
assuan_error_t assuan_set_okay_line (assuan_context_t ctx, const char *line);
assuan_error_t assuan_write_status (assuan_context_t ctx,
                                    const char *keyword, const char *text);

/* Negotiate a file descriptor.  If LINE contains "FD=N", returns N
   assuming a local file descriptor.  If LINE contains "FD" reads a
   file descriptor via CTX and stores it in *RDF (the CTX must be
   capable of passing file descriptors).  Under W32 the returned FD is
   a libc-type one.  */
assuan_error_t assuan_command_parse_fd (assuan_context_t ctx, char *line,
                                        assuan_fd_t *rfd);


/*-- assuan-listen.c --*/
assuan_error_t assuan_set_hello_line (assuan_context_t ctx, const char *line);
assuan_error_t assuan_accept (assuan_context_t ctx);
assuan_fd_t assuan_get_input_fd (assuan_context_t ctx);
assuan_fd_t assuan_get_output_fd (assuan_context_t ctx);
assuan_error_t assuan_close_input_fd (assuan_context_t ctx);
assuan_error_t assuan_close_output_fd (assuan_context_t ctx);


/*-- assuan-pipe-server.c --*/
int assuan_init_pipe_server (assuan_context_t *r_ctx, int filedes[2]);
void assuan_deinit_server (assuan_context_t ctx);

/*-- assuan-socket-server.c --*/
int assuan_init_socket_server (assuan_context_t *r_ctx, assuan_fd_t listen_fd);
int assuan_init_connected_socket_server (assuan_context_t *r_ctx, 
                                         assuan_fd_t fd) _ASSUAN_DEPRECATED;
int assuan_init_socket_server_ext (assuan_context_t *r_ctx, assuan_fd_t fd,
                                   unsigned int flags);
void assuan_set_sock_nonce (assuan_context_t ctx, assuan_sock_nonce_t *nonce);

/*-- assuan-pipe-connect.c --*/
assuan_error_t assuan_pipe_connect (assuan_context_t *ctx,
                                    const char *name,
				    const char *const argv[],
				    int *fd_child_list);
assuan_error_t assuan_pipe_connect2 (assuan_context_t *ctx,
                                     const char *name,
                                     const char *const argv[],
				     int *fd_child_list,
                                     void (*atfork) (void*, int),
                                     void *atforkvalue) _ASSUAN_DEPRECATED;
assuan_error_t assuan_pipe_connect_ext (assuan_context_t *ctx, 
                                        const char *name,
                                        const char *const argv[],
                                        int *fd_child_list,
                                        void (*atfork) (void *, int),
                                        void *atforkvalue,
                                        unsigned int flags);

/*-- assuan-socket-connect.c --*/
assuan_error_t assuan_socket_connect (assuan_context_t *ctx, 
                                      const char *name,
                                      pid_t server_pid);
assuan_error_t assuan_socket_connect_ext (assuan_context_t *ctx,
                                          const char *name,
                                          pid_t server_pid,
                                          unsigned int flags);

/*-- assuan-connect.c --*/
void assuan_disconnect (assuan_context_t ctx);
pid_t assuan_get_pid (assuan_context_t ctx);
#ifndef _WIN32
assuan_error_t assuan_get_peercred (assuan_context_t ctx,
                                    pid_t *pid, uid_t *uid, gid_t *gid);
#endif

/*-- assuan-client.c --*/
assuan_error_t 
assuan_transact (assuan_context_t ctx,
                 const char *command,
                 int (*data_cb)(void *, const void *, size_t),
                 void *data_cb_arg,
                 int (*inquire_cb)(void*, const char *),
                 void *inquire_cb_arg,
                 int (*status_cb)(void*, const char *),
                 void *status_cb_arg);


/*-- assuan-inquire.c --*/
assuan_error_t assuan_inquire (assuan_context_t ctx, const char *keyword,
                               unsigned char **r_buffer, size_t *r_length,
                               size_t maxlen);
assuan_error_t assuan_inquire_ext (assuan_context_t ctx, const char *keyword,
				   size_t maxlen,
				   int (*cb) (void *cb_data, int rc,
					      unsigned char *buf,
					      size_t buf_len),
				   void *cb_data);
/*-- assuan-buffer.c --*/
assuan_error_t assuan_read_line (assuan_context_t ctx,
                              char **line, size_t *linelen);
int assuan_pending_line (assuan_context_t ctx);
assuan_error_t assuan_write_line (assuan_context_t ctx, const char *line );
assuan_error_t assuan_send_data (assuan_context_t ctx,
                              const void *buffer, size_t length);

/* The file descriptor must be pending before assuan_receivefd is
   called.  This means that assuan_sendfd should be called *before* the
   trigger is sent (normally via assuan_write_line ("INPUT FD")).  */
assuan_error_t assuan_sendfd (assuan_context_t ctx, assuan_fd_t fd);
assuan_error_t assuan_receivefd (assuan_context_t ctx, assuan_fd_t *fd);


/*-- assuan-util.c --*/
void assuan_set_malloc_hooks ( void *(*new_alloc_func)(size_t n),
                               void *(*new_realloc_func)(void *p, size_t n),
                               void (*new_free_func)(void*) );
void assuan_set_io_hooks (assuan_io_hooks_t io_hooks);
void assuan_set_log_stream (assuan_context_t ctx, FILE *fp);
int assuan_set_error (assuan_context_t ctx, int err, const char *text);
void assuan_set_pointer (assuan_context_t ctx, void *pointer);
void *assuan_get_pointer (assuan_context_t ctx);

void assuan_begin_confidential (assuan_context_t ctx);
void assuan_end_confidential (assuan_context_t ctx);

void assuan_set_io_monitor (assuan_context_t ctx,
                            unsigned int (*monitor)(assuan_context_t ctx,
                                                    int direction,
                                                    const char *line,
                                                    size_t linelen));

/* For context CTX, set the flag FLAG to VALUE.  Values for flags
   are usually 1 or 0 but certain flags might allow for other values;
   see the description of the type assuan_flag_t for details. */
void assuan_set_flag (assuan_context_t ctx, assuan_flag_t flag, int value);

/* Return the VALUE of FLAG in context CTX. */ 
int  assuan_get_flag (assuan_context_t ctx, assuan_flag_t flag);


/*-- assuan-errors.c --*/

#ifndef _ASSUAN_ONLY_GPG_ERRORS
/* Return a string describing the assuan error.  The use of this
   function is deprecated; it is better to call
   assuan_set_assuan_err_source once and then make use libgpg-error. */
const char *assuan_strerror (assuan_error_t err);
#endif /*_ASSUAN_ONLY_GPG_ERRORS*/

/* Enable gpg-error style error codes.  ERRSOURCE is one of gpg-error
   sources.  Note, that this function is not thread-safe and should be
   used right at startup. Switching back to the old style mode is not
   supported. */
void assuan_set_assuan_err_source (int errsource);

/*-- assuan-logging.c --*/

/* Set the stream to which assuan should log message not associated
   with a context.  By default, this is stderr.  The default value
   will be changed when the first log stream is associated with a
   context.  Note, that this function is not thread-safe and should
   in general be used right at startup. */
extern void assuan_set_assuan_log_stream (FILE *fp);

/* Return the stream which is currently being using for global logging.  */
extern FILE *assuan_get_assuan_log_stream (void);

/* Set the prefix to be used at the start of a line emitted by assuan
   on the log stream.  The default is the empty string.  Note, that
   this function is not thread-safe and should in general be used
   right at startup. */
void assuan_set_assuan_log_prefix (const char *text);

/* Return a prefix to be used at the start of a line emitted by assuan
   on the log stream.  The default implementation returns the empty
   string, i.e. ""  */
const char *assuan_get_assuan_log_prefix (void);


/*-- assuan-socket.c --*/

/* These are socket wrapper functions to support an emulation of Unix
   domain sockets on Windows W32.  */
int assuan_sock_close (assuan_fd_t fd);
assuan_fd_t assuan_sock_new (int domain, int type, int proto);
int assuan_sock_connect (assuan_fd_t sockfd, 
                         struct sockaddr *addr, int addrlen);
int assuan_sock_bind (assuan_fd_t sockfd, struct sockaddr *addr, int addrlen);
int assuan_sock_get_nonce (struct sockaddr *addr, int addrlen, 
                           assuan_sock_nonce_t *nonce);
int assuan_sock_check_nonce (assuan_fd_t fd, assuan_sock_nonce_t *nonce);


#ifdef __cplusplus
}
#endif
#endif /* ASSUAN_H */
