% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Muôn Đời Hằng Sống" }
  composer = "Tob. 12,2-8"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \autoPageBreaksOff
  e8 (d) c e |
  f2 |
  f8. e16 d8 d |
  g4 r8 a |
  f4 d8 e |
  c4 r8 c16 e |
  d8 d f a |
  g4. e16 g |
  f8 f a c |
  b4 r8 b16 c |
  g8 a f d |
  c2 \bar "||"
  
  \pageBreak
  <> \tweak extra-offset #'(-6.7 . -2.7) _\markup { \bold "ĐK:" }
  g'8. e16 c8 f |
  f4. d8 |
  g8. f16 e8 g |
  a4 r8 g |
  g g4 g8 |
  c4. a8 |
  d e c a |
  g4 r8 f |
  g d4 f8 |
  g4. d8 |
  e f f d |
  c2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  R2*12
  g8. e16 c8 a |
  a4. c8 |
  b8. d16 c8 e |
  f4 r8 f |
  e e4 c8 |
  a'4. g8 |
  f g a f |
  e4 r8 d |
  c b4 d8 |
  e4. b8 |
  c d c b |
  c2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Chúc tụng Thiên Chúa, Đấng muôn đời hằng sống,
      Chúc tụng vương quốc Ngài,
      Ngài đánh phạt rồi lại xót thương,
      nhận đáy vực rồi lại kéo lên,
      Không có chi thoát khỏi tay Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Giữa lòng muôn nước, Hỡi dân Ít -- ra -- en,
	    Hết thảy hoan chúc Ngài,
	    Ngài phân lìa rồi lại góp gom,
	    để chúng rầy nhìn nhận rõ hơn
	    Thiên Chúa ta vĩ đại khôn lường.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Đánh phạt ta đó
	    Bởi ta làm điều ác
	    Chúa lại thương xót liền.
	    Gọi ta về từ muôn quốc gia,
	    từ bao địa hạt ta phát lưu
	    Nay Chúa thương kết hiệp ta lại.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Hãy về bên Chúa,
	    Sống theo sự thật luôn,
	    Hết dạ tôn kính Ngài,
	    Ngài sẽ trở lại cùng chúng ta,
	    và không còn ngoảnh mặt ngó lơ,
	    Mau hãy chung tiếng cảm tạ Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Chúc mừng Thiên Chúa, Đấng công bình, thành tín,
	    Thống trị muôn thế hệ,
	    Từ nơi tù đầy tôi nói lên
	    để hết mọi tội nhân biết luôn:
	    Thiên Chúa bao vĩ đại, uy quyền.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Các tội nhân hỡi, Hãy trở về cùng Chúa,
	    Sống đời ngay chính hoài,
	    Vì hy vọng Ngài lại chuẩn ưng
	    mà ghé mặt nhìn để xót thương
	    Cho số phận khổn khổ ta này.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Bái phục Thiên Chúa, Đấng tôi hằng thờ kính,
	    hớn hở ca hát Ngài,
	    Ngài luôn cầm quyền cả chức cao,
	    từ thánh điện Giê -- ru -- sa -- lem,
	    Nay hết thảy hãy ca tụng Ngài.
    }
  >>
  %\set stanza = "ĐK:"
  \set stanza = ""
  Trước muôn vàn sinh linh nào hãy suy phục Thiên Chúa,
  vì Ngài là Thượng Đế, là Thiên Chúa ta tôn thờ,
  là Thân phụ của ta, là Thiên Chúa đến muôn đời.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
    (set! all-grob-descriptions
          (cons ((@@ (lily) completize-grob-entry)
                 (cons grob-name grob-entry))
                all-grob-descriptions)))

#(add-grob-definition
   'StanzaNumberSpanner
   `((direction . ,LEFT)
     (font-series . bold)
     (padding . 1)
     (side-axis . ,X)
     (stencil . ,ly:text-interface::print)
     (X-offset . ,ly:side-position-interface::x-aligned-side)
     (Y-extent . ,grob::always-Y-extent-from-stencil)
     (meta . ((class . Spanner)
              (interfaces . (font-interface
                             side-position-interface
                             stanza-number-interface
                             text-interface))))))

\layout {
   \context {
     \Global
     \grobdescriptions #all-grob-descriptions
   }
   \context {
     \Score
     \remove Stanza_number_align_engraver
     \consists
       #(lambda (context)
          (let ((texts '())
                (syllables '()))
            (make-engraver
             (acknowledgers
              ((stanza-number-interface engraver grob source-engraver)
                 (set! texts (cons grob texts)))
              ((lyric-syllable-interface engraver grob source-engraver)
                 (set! syllables (cons grob syllables))))
             ((stop-translation-timestep engraver)
                (for-each
                 (lambda (text)
                   (for-each
                    (lambda (syllable)
                      (ly:pointer-group-interface::add-grob text
'side-support-elements syllable))
                    syllables))
                 texts)
                (set! syllables '())))))
   }
   \context {
     \Lyrics
     \remove Stanza_number_engraver
     \consists
       #(lambda (context)
          (let ((text #f)
                (last-stanza #f))
            (make-engraver
             ((process-music engraver)
                (let ((stanza (ly:context-property context 'stanza #f)))
                  (if (and stanza (not (equal? stanza last-stanza)))
                      (let ((column (ly:context-property context
'currentCommandColumn)))
                        (set! last-stanza stanza)
                        (if text
                            (ly:spanner-set-bound! text RIGHT column))

                        (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                        (ly:grob-set-property! text 'text stanza)
                        (ly:spanner-set-bound! text LEFT column)))))
             ((finalize engraver)
                (if text
                    (let ((column (ly:context-property context
'currentCommandColumn)))
                      (ly:spanner-set-bound! text RIGHT column)))))))
     \override StanzaNumberSpanner.horizon-padding = 10000
   }
}
% kết thúc mã nguồn

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1.2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
