% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Con Yêu Chúa Hết Lòng" }
  composer = "Tv. 17"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \autoPageBreaksOff
  %<> \tweak extra-offset #'(-6.5 . -2.2) _\markup { \bold "ĐK:" }
  a8 a b b |
  gs4. e8 |
  c'4 r8 c | \break
  c d e8. c16 |
  a8 b r a |
  a b c8. b16 |
  a8 e r e |
  b'4 b8 gs |
  a2 ~ |
  a4 r8 \bar "||" \break
  
  a16 f |
  e4 \tuplet 3/2 { e8 e a } |
  b4 r8 c16 a |
  
  \pageBreak
  
  d4 \tuplet 3/2 { c8 d e } |
  a,4 r8 c16 b |
  b4 \tuplet 3/2 { g8 a f } |
  e4 r8 c16 \slashedGrace { c16 ( } d) |
  e4 \tuplet 3/2 { b'8 c b } |
  a2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  a8 a b b |
  gs4. e8 |
  c'4 r8 a |
  a b c8. a16 |
  f8 e r c |
  c d e8. d16 |
  d8 c r c |
  d4 e8 e |
  c2 ~ |
  c4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Con yêu Chúa hết lòng,
  lạy Chúa, ngài là núi đá con tựa nương,
  là thành kiên cố con ẩn mình,
  Lạy Đấng Cứu Độ con
  <<
    {
      \set stanza = "1."
      Sóng tử thàn dồn dập muôn lớp,
      thác diệt vong làm con khiếp sợ,
      Lưới âm ty bủa vây tư bề,
      Tròng thần chết giăng mắc nơi nơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Lúc ngặt nghèo nguyện cầu lên Chúa,
	    Chúa của con từ nơi thánh điện
	    Lắng tai nghe lời con khẩn nài
	    Hằng vọng thấu lên Thánh Nhan liên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Đất trở mình ầm ầm rung chuyển,
	    núi đồi cao từng cơn chấn động
	    Chúa dương oai bừng cơn lửa giận,
	    Và nộ khí ngun ngút xông lên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chốn cửu trùng Ngài chìa tay vớt,
	    Nhắc hồn tôi khỏi cơn nước lụt,
	    Cứu thân tôi khỏi tay bạo tàn,
	    Khỏi kẻ dữ uy thế hơn tôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Chính bởi vì lòng hằng trung tín,
	    Giữ bàn tay chẳng vương ố tỳ,
	    Những kiên trung tuân giữ luật Ngài,
	    Ngài đổ xuống ân phúc dư đầy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Huấn lệnh Ngài, lòng hằng ghi nhớ,
	    Quyết thủy chung tìm theo lối Ngài
	    Giữ tâm tư không nhiễm tội tình,
	    Lề luật Chúa không chút đơn sai.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Chúa tận tình cùng người tận nghĩa,
	    Tín thành luôn cùng ai tín thành,
	    Ở công minh cùng ai công bình,
	    Dùng diệu kế với đứa gian ngoa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Dân khổ nghèo, Ngài hằng săn sóc,
	    Đứa tự cao Ngài xô ngã gục,
	    Chiếu soi cho đời con mịt mù,
	    Ngọn đèn sáng xin thắp cao lên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Tín cậy Ngài, vào trận giao chiến,
	    Sức thần thiêng vượt bao lũy thành,
	    Chúa nên như khiên thuẫn độ trì,
	    Kẻ ẩn náu bên Chúa hôm mai.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "10."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa mở rộng nẻo đường con bước,
	    Quyết đuổi theo diệt quân ác thù,
	    Giữ chân con chẳng khi xiêu vẹo,
	    Cậy vào Chúa, con mãi kiên cường.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "11."
	    Chúc tụng Ngài ngàn đời, muôn kiếp,
	    Đấng trường sinh giầu ơn cứu độ,
	    Đã cho con rửa mối hận này,
	    Được vạn quốc cung cúc suy tôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "12."
      \override Lyrics.LyricText.font-shape = #'italic
	    Cám tạ Ngài từ lòng muôn nước,
	    Tấu đàn lên mừng danh thánh Ngài,
	    Cứu thân con khỏi tay kẻ thù,
	    Và hiển thắng trên khắp chư dân.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 10\mm
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
  page-count = #2
  ragged-bottom = ##t
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
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
     (padding . 0.5)
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
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
